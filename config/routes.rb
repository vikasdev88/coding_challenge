Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'store#index', as: :store_root
  end

  root to: 'visitors#index'

  resources :ovens do
    resource :cookies
    member do
      post :empty
    end
  end

  resources :orders, only: [:index]

  namespace :api do
    resources :orders, only: [:index] do
      put :fulfill, on: :member
    end
  end

  # mount MailPreview => 'mail_view' if Rails.env.development?
end
