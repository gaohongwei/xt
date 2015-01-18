module Api::V1
class OptionUsersController < AdminController
  #skip_before_filter :authenticate_user!  
  protect_from_forgery
  respond_to :json 
  def index
    # Find root task_id for this task  if it is not root task   
    # Find all children task_id for 
    # Find all option_id for a user on this task   
    # save as {task_id:[option_id,...]}
    login User.guest if current_user.nil?
    uid= params[:uid]
    tid= params[:tid]
    if uid && uid == 'me'
      uid=current_user.id
    end
    objs=OptionUser.get_options(tid,uid)
    respond_with objs   
  end 
  def create
    logger.debug "user_id=#{current_user.id}"    
    login User.guest if current_user.nil?
    user_id=current_user.id 
    new_option_ids=params[:option_user][:opts]    
    OptionUser.set_options(new_option_ids,user_id) 
    #respond_with new_option_ids 
    logger.debug "user_id=#{user_id}"
    render :json => {:options => new_option_ids}
  end  
  def show
    @obj=OptionUser.find(params[:id])
    respond_with @obj      
  end  
  private
    # Use callbacks to share common setup or constraints between actions.
    # Only allow a trusted parameter "white list" through.
    def get_params
      #params.require(:task_option).permit(:task_id, :name, :description, :vote, :user_id)
      params.require(:option_user).permit!
      #params.require(:opts).permit!
    end

    #def search_col
      #TaskOption.column_names[1]
    #end     
end
end