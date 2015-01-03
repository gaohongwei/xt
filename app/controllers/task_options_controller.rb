class TaskOptionsController < AdminController0
  def index
    id= params[:id]
    if id 
      @objs=TaskOption.by_task(id)
    else
      @objs=TaskOption.all
    end
    respond_with @objs
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