class TasksController < AdminController
  def index_scope
    task_id=params[:id]
    if task_id
      task=Task.find(task_id).root
      task_ids=task.descendant_ids  
      task_ids<<task_id unless task_ids.include?(task_id)
      @objs = Task.by_ids(task_ids).page(params[:page]).per(10)
    else
      @objs = Task.top.page(params[:page]).per(10) 
    end
  end   
  def show
    current_user||=User.find(2)
    task_id= params[:id]    
    scope= params[:scope]
    if scope  && scope == 'option'
      if task_id 
        task=Task.find(task_id).root
        task_ids=task.descendant_ids  
        task_ids<<task_id unless task_ids.include?(task_id)
      end        
      @objs=TaskOption.includes(:task).by_task(task_ids)      
    else
      @obj=Task.find(params[:id])
      @root_id=@obj.root_id
      @user_id=current_user.id 
    end        
  end
  def new
    pid=params[:pid]
    @obj=Task.new(parent_id:pid,pid:pid,active:true,user_id:current_user.id,public:false)
  end  

  private
    # Use callbacks to share common setup or constraints between actions.


    # Only allow a trusted parameter "white list" through.
    def get_params
      #params.require(:menu).permit(:name, :title, :url, :ancestry, :pid, :order_by, :user_id)
      params.require(:task).permit!
    end

end