module Api::V1
class GroupsController < AdminController
  #skip_before_filter :authenticate_user!  
  protect_from_forgery
  respond_to :json 
  def update
    id=params[:id]
    if id
      if id == 'new'
        #gid,uid,rid=params[:gid],params[:uid],params[:rid]


      else


      end 
    end

  end  
 
  private
    # Use callbacks to share common setup or constraints between actions.
    # Only allow a trusted parameter "white list" through.
    def get_params
      #params.require(:task_option).permit(:task_id, :name, :description, :vote, :user_id)
      params.require(:group).permit!
      #params.require(:opts).permit!
    end

    #def search_col
      #TaskOption.column_names[1]
    #end     
end
end