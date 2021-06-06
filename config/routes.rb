Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
    path: '',
    path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},

    resources :users, only: [:show]
    
    resources :posts, only: [:index, :show, :create] do
      resources :photos, only: [:create]
end