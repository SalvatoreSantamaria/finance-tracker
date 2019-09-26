Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "user/registrations"} #look at user/registrations controller first.
  resources :user_stocks, only: [:create, :destroy] #for a button link in _result.html.erb | #only want the create and destroy routes here
  resources :users, only: [:show] #for my_friends.html.erb
  resources :friendships


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'my_portfolio', to: "users#my_portfolio" #going to users controller, my_portfolio action
  get 'search_stocks', to: 'stocks#search' #unsure if this is outdated
  get 'my_friends', to: "users#my_friends" #users controller, my_friends action
  get 'search_friends', to: "users#search" #users conroller, search action 
  post 'add_friend', to: "users#add_friend" #users controller, add_friend action (method)
end
