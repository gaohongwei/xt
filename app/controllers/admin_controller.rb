require 'crud_helper'
class AdminController < ApplicationController
  before_filter :authenticate_user_or_qq!, only:[:new,:create,:edit,:update, :show,:destroy] 
  before_action :set_obj, only: [:show, :edit, :update, :destroy]
  #skip_authorize_resource :devise
  #load_and_authorize_resource 
  rescue_from CanCan::AccessDenied do |exception|
    msg=tt("denied")
    logger.error exception.message
    logger.error exception.backtrace.join("\n")    
    redirect_to root_url, notice:msg    
  end 
  rescue_from ActiveRecord::RecordNotFound do |exception|
    msg=tt("no_such_data")
    logger.error exception.message
    logger.error exception.backtrace.join("\n")    
    redirect_to root_url, notice:msg
  end 

  before_filter do  # fix ActiveModel::ForbiddenAttributesError
    resource = controller_name.singularize.to_sym
    method = "get_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end 

  def record_not_found  
    flash[:notice] = "No specified data."
    redirect_to :action => 'index' 
  end  
  def current_ability
      @current_ability ||= Ability.new(current_user)
  end        
  def after_sign_in_path_for(user)
    admin_menus_path
  end 

  def authenticate_user_or_qq!
    #logger.debug "authenticate_user_or_qq"   
    #login_qq() 
    authenticate_user! 
    #login_guest if current_user.nil?
    #logger.debug "user=#{current_user.id} "    
  end  
  def login_qq()
    if current_user 
      logger.debug "======================================"
      logger.debug "You have logged in before"
    else
      qq=get_qq()
      if qq
        current_user=User.find_or_add_by_qq(qq)  
        sign_in current_user    
        logger.debug "======================================"
        logger.debug "You logged in with your qq#{qq} just now"
      else
        logger.debug "======================================"
        logger.debug "Not logged in QQ"
      end
    end
  end  

  def get_qq
    return nil#'1234567'
  end  
end