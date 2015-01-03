module Api::V1
class TasksController < AdminController
  protect_from_forgery
  respond_to :json  
  def show
    current_user||=User.find(2)    
    t=Task.find(params[:id])
    @root_id=t.root_id
    @user_id=current_user.id    
    @obj=[get_nested(t,[:name,:id])]
  end
  def new
    pid=params[:pid]
    @obj=Task.new(parent_id:pid,pid:pid,active:true,user_id:current_user.id)
  end  
  def index
    id= params[:id]
    if id 
      t=Task.find(id)
      @objs=[get_nested(t,[:name,:id,'user.vname','user.id',:options])]
    else
      @objs = Task.top
    end
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
end