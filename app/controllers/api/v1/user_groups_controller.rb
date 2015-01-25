module Api::V1
class UserGroupsController < AdminController
  skip_before_action :set_obj
  protect_from_forgery
  respond_to :json 
  def index
    @objs=UserGroup.all
    respond_with @objs   
  end
  def show # index and show
    id=params[:id]
    if id
      #@obj=UserGroup.find(id)        
    end #id
    respond_with @obj    
  end
  def update # new and update   
    id=params[:id] # We are not using id
    res={rc:0,mes:''}
    gid=params[:group_user][:gid]
    uid=params[:group_user][:uid]
    rid=params[:group_user][:rid]               
    UserGroup.update(uid,gid,rid)
    logger.debug "======================="
    logger.debug "uid=#{uid} gid=#{gid} rid=#{rid}"  
    logger.debug "p=#{params}"       
    respond_with res   
  end   
 
  private
    # Use callbacks to share common setup or constraints between actions.
    # Only allow a trusted parameter "white list" through.
    def get_params
      #params.require(:task_option).permit(:task_id, :name, :description, :vote, :user_id)
      params.require(:group_user).permit!
      #params.require(:opts).permit!
    end

    #def search_col
      #TaskOption.column_names[1]
    #end     
end
end