class Admin::WidgetsController < AdminController
  #before_action :set_widget, only: [:show, :edit, :update, :destroy]
  def new
    pid=params[:pid]
    @obj=Widget.new(parent_id:pid,pid:pid)    
  end
  def create
    @obj=Widget.new(get_params)  
    fill_user_id()
    if @obj.save
      after_create      
      redirect_to_ns @obj, notice: tt('created')
    else
      render action: 'new'
    end       
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_widget
      @widget = Widget.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def get_params
      #params.require(:widget).permit(:name)
      params.require(:widget).permit!
    end  
    def after_create
      @obj.save_partial()
    end  
    def after_update
      @obj.save_partial()      
    end      
end