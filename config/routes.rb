Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'my_portfolio', to: "users#my_portfolio" #going to users controller, my_portfolio action
  get 'search_stocks', to: 'stocks#search' #unsure if this is outdated
end
