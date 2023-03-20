Rails.application.routes.draw do
  
  root to: "home#index"
  
  devise_for :users
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    # get '/users/password', to: 'devise/passwords#new'
  end
    
  resources :tickets 
  get '/ticket/:department_selected_option', to: 'tickets#fetch'
  
end







# devise_for :users, :controllers => {:registrations => "registrations"}
  #        :skip => [:registrations]
        

  # devise_scope :user do
  #   get "user/sign_up", to: "users/registrations#new", as: :new_user_registration
  #   post "user/sign_up", to: "users/registrations#create", as: :user_registration
  #   get "user/edit", to: "users/registrations#edit", as: :edit_user_registration
  # end

  # get 'home/index' , to: 'home#index'
  # get 'home/show',to: 'home#show'
  # get '/home/:department_selected_option', to: 'home#fetch'
  
  # resources :users