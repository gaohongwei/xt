class Admin::UsersController < AdminController
  #before_action :set_widget, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :only => [:edit,:update,:show,:destroy]
  before_filter :authenticate_user!, :except => [:new,:create,:index] 

  def new
    @obj= User.new
    #respond_with(@user)
  end
  def create_password
      pwd = Devise.friendly_token.first(6)
      params[:user][:password] ||=pwd
      params[:user][:password_confirmation] ||=pwd
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