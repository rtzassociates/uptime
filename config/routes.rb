Uptime::Application.routes.draw do
  
  get "pages/home"
  root :to => "pages#home"
  
  
  resources :servers
  resources :application_servers
  resources :database_servers
  resources :windows_servers
  resources :xen_servers
  
  resources :server_locations
  resources :server_types
  resources :networks
  resources :databases
  resources :sites
  resources :statuses
  resources :sessions
  resources :comments
  resources :subscriptions
  resources :password_resets
  
  resources :events do
    resource :problem
    resource :resolution
  end
  
  resources :users do
    collection do
      get :current
    end
    resources :emails
  end
 
  match "signout" => "sessions#destroy"
  match "login" => "sessions#new"
  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :application_servers
    end
  end
  
end
