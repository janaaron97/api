Rails.application.routes.draw do
  root 'users#index'
  resources :users
  resources :items
	post 'authenticate', to: 'authentication#authenticate'
end



