class AuthenticationsController < ApplicationController  
  #protect_from_forgery with: :exception
  def index  
    @authentications = current_user.authentications if current_user 
    render json: @authentications
  end  
  def linkedin_client
    client_id,client_secret = "75rf530owl7q90", "ULttu46PLcyrsAdN"  
    client = OAuth2::Client.new(client_id,client_secret,
      :authorize_url => "/uas/oauth2/authorization?response_type=code", #LinkedIn's authorization path
      :token_url => "/uas/oauth2/accessToken", #LinkedIn's access token path
      :site => "https://www.linkedin.com"
    )
  end

  def create  
    omniauth = params
    code=params[:oauth_token]   
    logger.debug "####################"
    logger.debug "code=#{code}"
    logger.debug "#{omniauth.inspect}"    
    logger.debug "####################"  
    provider=params[:provider]
    cookies[:provider] = provider   
    #logger.debug "request.env=#{request.env}"    

    auth=request.env["omniauth.auth"]
    #render :text => auth.to_yaml     
    #@auth||=request.env[:omniauth.auth]    
    if auth.nil?
      #flash[:notice] = "Signed in failed." 
      redirect_to "/"      
      logger.debug "####################"
      logger.debug "####################"
    else
      provider=auth[:provider]
      uid=auth[:uid]      
      info=auth[:info]
      email=info[:email]
      vname=info[:name]
                  
    end 
    case provider
    when 'twitter'
        vname=info[:nickname]
        email="#{uid}@#twitter.com"
    when 'qq_connect'
        vname=info[:nickname]
        email="qq_#{uid}@qq.com"        
    end
    logger.debug "info=#{info}" 
    logger.debug "email=#{email}"  
    logger.debug "provider=#{provider} uid=#{uid}"         
    #linkedin = Linkedin.new("75rf530owl7q90", "ULttu46PLcyrsAdN")
    #ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
    #client=linkedin.client
=begin
    client_id,client_secret = "75rf530owl7q90", "ULttu46PLcyrsAdN"
    scope = 'r_fullprofile r_emailaddress r_network'
    redirect_uri = "http://192.168.138.131:3000/"
    #redirect_uri = "http://xietiao.herokuapp.com/"
    client_options={        
      site:'https://api.linkedin.com',
      authorize_url:'https://www.linkedin.com/uas/oauth2/authorization?response_type=code',
      token_url:'https://www.linkedin.com/uas/oauth2/accessToken'}

    client = OAuth2::Client.new(client_id, client_secret,client_options)

    code=params[:oauth_token]   
    logger.debug "####################"
    logger.debug "code=#{code}"
    logger.debug "####################"   

    access_token = client.auth_code.get_token(code, redirect_uri: redirect_uri)        
    logger.debug "####################"
    logger.debug "#{client.inspect}"
    logger.debug "#{access_token.inspect}"    
    logger.debug "####################"
=end
    authentication = Authentication.find_by_provider_and_uid(provider, uid)  
    if authentication  
      #flash[:notice] = "Signed in successfully." 
      #flash[:notice] = "auth=#{omniauth['provider']}" 
      authentication.user.provider=provider       
      sign_in_and_redirect(:user, authentication.user)  
    elsif current_user  
      current_user.authentications.create(provider:provider, uid:uid)
      current_user.provider=provider 
      #flash[:notice] = "Authentication successful."  
      redirect_to root_path  
    else  
      email||=omniauth['oauth_token'].to_s+'@'+provider
      user = User.find_or_create(email,vname)
      user.authentications.build(provider:provider, uid:uid)  
      #user.save! 
      user.save  
      #flash[:notice] = "Signed in successfully."  
      sign_in_and_redirect(:user, user) 
      current_user.provider=provider        
    end 
      current_user.provider=provider        
  end    
end  