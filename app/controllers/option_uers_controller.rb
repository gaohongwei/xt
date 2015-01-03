class OptionUersController < AdminController
  def index
    uid= params[:uid]
    tid= params[:tid]
    if uid && uid == 'me'
      uid=current_user.id
    end
    if uid && tid 
      @objs=OptionAnswer.by_task(tid).by_user(uid)
    else
      if uid
        @objs=OptionAnswer.by_user(uid) 
      elsif tid
        @objs=OptionAnswer.by_task(tid)
      else
        @objs=OptionAnswer.all
      end
    end
    respond_with @objs  
  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    # Only allow a trusted parameter "white list" through.
    def get_params
      #params.require(:task_option).permit(:task_id, :name, :description, :vote, :user_id)
      params.require(:task_option_answer).permit!
    end

    #def search_col
      #TaskOption.column_names[1]
    #end     
end