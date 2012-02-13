Txtapp::Application.routes.draw do

  get "sessions/new"
  
  resources :users, :only => [:new, :create, :destroy, :show, :edit, :update]
  #match '/users/:id' => 'users#show', :via => :get
  
  get "pages/about"
  
  match '/signup' => 'users#new'
  
  resources :sessions, :only => [:new, :create, :destroy]
  match '/signin' => 'sessions#new'
  match '/signout' => 'sessions#destroy'
  
  resources :messages, :only => [:new, :create, :destroy] do
    resources :comments, :only => [:create, :destroy]
  end
  
  #resources :messages do
  #  resources :comments
  #end
  
  resources :password_resets
  
  match '/messages' => 'messages#new'  
  
  match '/:pickUpCode'      => 'messages#show', :via => :get
  match '/:pickUpCode/edit' => 'messages#edit', :via => :get
  match '/:pickUpCode'      => 'messages#update', :via => :put
 
 match '/messages/new' => 'messages#new'

 root :to => "messages#new"
  match "/messages/:id" => redirect("/")
end
