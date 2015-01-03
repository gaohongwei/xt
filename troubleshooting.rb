
1.Failed to create task if use "has_ancestry "
No route matches {:action=>"show", :controller=>"tasks"}
controller=
act=show
label=显示
id=

Solution: remove ancestry input filed from form

2. POST http://ip/api/v1/task_options 404 (Not Found)
 Solution:Add routes

3. PUT http://ip/api/v1/task_option_answers/1 401 (Unauthorized)
 Can't verify CSRF token authenticity
 Can't verify CSRF token authenticity
Completed 401 Unauthorized in 3ms
Solution:

4. Failed to logout from devise user
devise need 
//= require jquery_ujs
# Devise need jquery-rails/jquery_ujs 
gem 'jquery-rails'

5. Auto login 
  def login_in()
  # Developemt, debug  
    #current_user ||=User.find(1)
    #sign_in current_user   
  end 
6 /app/app/models/setting:string.rb:1: syntax error, unexpected tSYMBEG, expecting
  rails g settings setting

7 Run in production
RAILS_ENV=production rake assets:precompile
config/initializers/devise.rb
  config.secret_key = '66cd920e65515ef6cd42bf593f61bde8cea97b34741155c30a887f84fb932319492f3710b2d1281504abd664ec9a1d86861f4e3412b052a8f3b422119f52a462'

config/secrets.yml
secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
  secret_key_base: b6dce532ffcfbf9d5df8f8ce0c9f901865e10c951c3edc312b2b8613110f373d84f8759ff149ce16ada8ad58a128f65bf2cd38b80bd252e63bb698050be5a052

Tell Rails to serve static files. 
config/environments/production.rb
config.serve_static_assets = true
config.assets.js_compressor = Uglifier.new(mangle: false)

  8.
  Resource interpreted as Stylesheet but transferred with MIME type text/html
  Refused to execute script from 'http://IP/assets/application.js' because its MIME type ('text/html') is not executable, and strict MIME type checking is enabled.


