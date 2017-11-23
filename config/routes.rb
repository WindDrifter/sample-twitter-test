Rails.application.routes.draw do
  resources :posts
  resources :users
  root to: 'indexs#index'
  resources :sessions
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/follow_user/:id', to: 'users#follow_user', via: 'post', as: :follow_user
  match '/unfollow_user/:id', to: 'users#unfollow_user', via: 'delete', as: :unfollow_user
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
