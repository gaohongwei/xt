class UsersController < AdminController
  #before_action :set_widget, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :only => [:edit,:update,:show,:destroy]
  before_filter :authenticate_user!#,:except => [:new,:create,:index] 
  def index_scope
    # if current_user.admin?
    # if current_user.group_owner?(gid)
    # if current_user.group_admin?(gid)
    # if current_user.joined_group(gid) #approved           
    gid=params[:group_id]
    #return if gid # already processed      
    #@objs= @objs.by_group(gids)
    if current_user.admin?      
      #@objs= @objs.all # No rectriction
      logger.debug "=================="
      logger.debug "current_user.admin" 
      logger.debug "=================="               
    else
      gids=current_user.joined_group_ids        
      @objs= @objs.by_group(gids)
      logger.debug "=================="
      logger.debug "not admin"         
    end     

    params[:gids]=gids   
    params[:index_scope]=@objs.inspect     
  end
  def index_customize
    gid=params[:group_id]
    return if gid.nil?

    group=Group.find(gid) 
    if group && can?(:manage, group)
      @checkbox=[
        {label:'allow_read', call:"update('UserGroups',#{gid},'read')"},
        {label:'allow_write',call:"update('UserGroups',#{gid},'write')"},
        {label:'allow_admin',call:"update('UserGroups',#{gid},'admin')"},
        {label:'deny',       call:"update('UserGroups',#{gid},'denied')"},
      ]
      gname=group.name
      @header=tts('user list,group:') + gname
      @column_ui='email;vname;my_role=role;active'
      @objs.each_with_index do |user,index|
        #user.set_role_of_group(gid)
        user.my_role=user.role_of_group(gid)
      end
    end
  end  
  def new
    @obj= User.new
    #respond_with(@user)
  end
  def create_password
      pwd = Devise.friendly_token.first(8)
      params[:user][:password] ||=pwd
      params[:user][:password_confirmation] ||=pwd
  end
  def create2
      pwd = Devise.friendly_token.first(8)
      email=params[:user][:email]
      @obj = User.new(email:email,password:pwd)
      #password_confirmation => 'password')
      @obj.save  
      #respond_with @obj
      redirect_to_ns @obj, notice: tt('created')        
  end

  def create
    create_password    
    @obj=model.send("new",get_params)   
    if @obj.save
      after_create      
      redirect_to_ns @obj, notice: tt('created')
    else
      render action: 'new'
    end        
  end

  def create0
    create_password
    @obj = User.new(params[:user])
    if @obj.save 
       flash[:notice] = "User #{@obj.email} was successfully created."
       #respond
    else
       flash[:notice] = "User #{@obj.email} was not created."
       render :new
    end
  end  

  private
    def get_params
      params.require(:user).permit!
    end

    #def search_col
      #Admin::Article.column_names[1]
    #end    
end