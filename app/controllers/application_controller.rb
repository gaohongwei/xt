class ApplicationController < ActionController::Base
  protect_from_forgery  
  #protect_from_forgery with: :exception

  before_filter :set_locale 
  respond_to :html, :xml, :json
  layout:'application'
  include ApplicationHelper
  include CrudHelper 

  layout :layout_by_resource  
  def layout_by_resource
    #if devise_controller?
      "application"
  end 
  def set_locale
    I18n.locale = 'zh-CN' #extract_locale
  end   
  def extract_locale
    allowed_env = %w{en zh-CN} #english, japanese only
    env = (request.env['HTTP_ACCEPT_LANGUAGE'] || "").scan(/^[a-z]{2}/).first
    allowed_env.include?(env) ? env : env = "en" #default to english
  end  

end