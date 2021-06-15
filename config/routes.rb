Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root to: 'top#index'
  get 'top/about',as: 'about'
  get 'posts/search'
  get 'messages/index',to: 'messages#index'
  post 'messages/confirm',to: 'messages#confirm'
  post 'messages/done',to: 'messages#done'
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
  resources :notifications,only:[:index] do
    collection do
      delete 'destroy_all'
    end
  end
end
