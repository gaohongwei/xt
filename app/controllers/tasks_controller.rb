class TasksController < AdminController
  def show
    current_user||=User.find(2)
    @obj=Task.find(params[:id])
    @root_id=@obj.root_id
    @user_id=current_user.id         
  end
  def new
    pid=params[:pid]
    @obj=Task.new(parent_id:pid,pid:pid,active:true,user_id:current_user.id,public:false)
  end  
  def index
    @objs = Task.top.page(params[:page]).per(10) 
    respond_with @objs
  end 
  private
    # Use callbacks to share common setup or constraints between actions.


    # Only allow a trusted parameter "white list" through.
    def get_params
      #params.require(:menu).permit(:name, :title, :url, :ancestry, :pid, :order_by, :user_id)
      params.require(:task).permit!
    end

end