require 'crud_helper'
class AdminController < ApplicationController
  before_filter :authenticate_user!, only:[:new,:create,:edit,:update, :destroy] 
  before_action :set_obj, only: [:show, :edit, :update, :destroy]  

  include ApplicationHelper
  include CrudHelper 
  
  #skip_authorize_resource :devise
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, notice:tt("denied")
  end 
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, notice:tt("no_such_data")
    #:laert=>exception.message
  end 
  #rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  before_filter do  # fix ActiveModel::ForbiddenAttributesError
    resource = controller_name.singularize.to_sym
    method = "get_params"
    params[resource] &&= send(method) if respond_to?(method, true)
    #login_in()
  end 
  load_and_authorize_resource 
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
end