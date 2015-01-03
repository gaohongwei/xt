Rails.application.routes.draw do  
  devise_for :users do
    get 'sign_out' => 'devise/sessions#destroy'
    get 'logout' => 'devise/sessions#destroy'    
  end    
  get "pages/show"
  namespace :admin do 
    resources :words     
    resources :gallery_media
    resources :galleries
    resources :galleries do
      resources :media
    end   
    resources :media
    resources :events
    resources :types do
      resources :articles
    end
    resources :articles
    resources :wpages
    resources :templates
    resources :widgets
    resources :menus
    resources :view_adms
    resources :user_groups
    resources :groups do
      resources :users
    end
    resources :settings  
    resources :users             
  end
  resources :tasks 
  resources :task_types 
  resources :task_options  
  resources :task_option_answers 
  resources :roles   
  resources :groups    
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :tasks
      resources :task_options        
      resources :option_users     
    end
  end

  get '/news/media-resources' => 'application/pages#show', url: 'news/media-resources'

  get '/news/news-releases' => 'application/news#index', filter: 'News Releases', as: :news_releases
  get '/news/press-coverage' => 'application/news#index', filter: 'Press Coverage', as: :press_coverage
  get '/news/news-releases/:permalink' => 'application/news#show', as: :news
  # Redirect url
  
  #get '/news/news' => 'application/news#index', type:'news' 
  #get '/news/notice' => 'application/news#index',type:'notice' 
  #get '/news/news&notice' => 'application/news#index',type:'news&notice' 
  #get '/news/all' => 'application/news#index', filter: 'All' 
  get '/papers/:permalink' => 'application/news#show' #, as: :news    
  get '/news/:type' => 'application/news#index'      
  get '/news' => 'application/news#index',type:'news&notice'
  get '/slideshow/:permalink' => 'application/news#slideshow',as: :slideshow
  # This two have to be the last lines
  get "/*url" => "application/pages#show", as: :page
  root :to=>"application/pages#show",url:"index"
end