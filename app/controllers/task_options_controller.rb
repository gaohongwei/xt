class TaskOptionsController < AdminController
  def index_scope
    id= params[:id]
    if id 
      @objs=TaskOption.by_task(id).page(params[:page]).per(10)
    else
      @objs=TaskOption.all.page(params[:page]).per(10)
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