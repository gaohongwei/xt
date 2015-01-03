class Admin::ViewAdmsController < AdminController

  def create
    actions=["index","show","edit"]
    if params[:view_adm][:name].nil? ||
       params[:view_adm][:name].empty?
      logger.debug "----------------------no params"            
      redirect_to_ns view_adms_path   
    else # have params
      name=params[:view_adm][:name]
      model_name=name.singularize.classify 
      model=nil   
      begin
        model=model_name.constantize
      rescue
        model=nil        
      end   
      unless defined?(model)
        logger.debug "----------------------#{model_name} not an data model"    
        #render :action => :index     
        redirect_to view_adms_path  
      else # if not an data model
        uid=current_user.id if current_user
        cols=model.column_names
        cols.delete_if {|w|w=='id'} 
        cols.delete_if {|w|w=='created_at'}
        cols.delete_if {|w|w=='updated_at'}
        cols=cols.join(';')                   
        ds=ViewAdm.by_controller(name)
        if ds.empty?
          actions.each do |action|
            ViewAdm.create!(
              name:name,
              action_scope:action,
              cols:cols,
              caps:cols,
              user_id:uid
              )
          end # of each
          logger.debug "==========================#{name}"        
          redirect_to admin_view_adms_path
        else #!ds.nil?
          @obj=ViewAdm.new(get_params) 
          fill_user_id()   
          @obj.save     
          logger.debug "---------------------------Created." 
          redirect_to admin_view_adms_path 
        end #ds.nil?
      end # of model defined?  
    end # of if params
    #@objs = ViewAdm.all
    #render :action => :index
  end
  private
    # Use callbacks to share common setup or constraints between actions.


    # Only allow a trusted parameter "white list" through.
    def get_params
      #params.require(:view_adm).permit(:name, :action_scope,:caps,:cols)
      params.require(:view_adm).permit!
    end

end