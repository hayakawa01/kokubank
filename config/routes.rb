Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root to: 'posts#index'
  get 'posts/search'
  resources :posts do
    resources :comments, only:[:create]
    resource :likes, only:[:create, :destroy]
    collection do
      get :search
    end
  end
  resources :grades,only:[:index,:show]
  resources :users do
    member do
      get :likes
    end
  end
end
