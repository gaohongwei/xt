module Api::V1
class TaskOptionsController < AdminController
  skip_before_filter :authenticate_user!     
  protect_from_forgery
  respond_to :json 
  def index
    current_user||=User.guest      
    task_id= params[:tid]
    if task_id 
      task=Task.find(task_id)
      task_ids=task.descendant_ids  
      task_ids<<task_id unless task_ids.include?(task_id)
      objs=TaskOption.by_task(task_ids)
    else
      objs=TaskOption.all
    end

    opr = params[:opr]    
    if opr && opr=='count' 
      votes=TaskOption.user_vote
      render :json => votes           
    else 
      options_by_task={}
      objs.each do |obj|
        task_id=obj.task_id
        options_by_task[task_id]||=[]
        opt={}
        opt[:id]=obj.id
        opt[:name]=obj.name
        opt[:user_id]=obj.user_id      
        opt[:user_name]=obj.user.vname if obj.user
        opt[:count]=1
        options_by_task[task_id]<<opt
      end
      render :json => [options_by_task]      
    end   
  end 
  def create
    #set_current_user() 
    current_user||=User.guest 
    logger.debug "current_user=#{current_user.id}"          
    @obj=TaskOption.new(params[:task_option])
    fill_user_id(current_user.id) 
    logger.debug "uid=#{@obj.user_id}"     
    if @obj.save
      respond_with @obj
    else
      render :json => {error:'error'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Only allow a trusted parameter "white list" through.
    def get_params
      #params.require(:task_option).permit(:task_id, :name, :description, :vote, :user_id)
      params.require(:task_option).permit!

    end

    #def search_col
      #TaskOption.column_names[1]
    #end     
end
end