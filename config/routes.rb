Rails.application.routes.draw do
  get 'top/index'
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root to: 'top#index'
  get 'posts/search'
  resources :posts do
    resources :comments, only:[:create, :destroy]
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
