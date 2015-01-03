class ApplicationController < ActionController::Base
  before_filter :set_locale  
  protect_from_forgery
  respond_to :html, :xml, :json
  layout:'application'

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