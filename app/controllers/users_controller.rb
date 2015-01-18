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
    if gid
      # already processed
      #@objs= @objs.by_group(gids)
    else
      if current_user.admin?
        # No rectriction
        #@objs= @objs.all
      else
        gids=current_user.group_ids        
        @objs= @objs.by_group(gids)
      end     
    end
    params[:gids]=gids   
    params[:index_scope]=@objs.inspect     
  end
  def index_last
    gid=params[:group_id]
    group=Group.find(gid)
    if gid && can?(:manage, group)
      @checkbox=[
        {label:'approve',  call:"add('/users')"},
        {label:'kickout',call:"delete('/users')"},
      ]
      gname=group.name
      @header=tts('user list,group:') + gname
      caption_columns='email;vname;active'
      @columns = get_array(caption_columns,0)
      @captions= get_array(caption_columns,1) 
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