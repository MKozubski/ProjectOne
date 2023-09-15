Rails.application.routes.draw do
  get 'about/index'
  resources :breeds, only: [:index] do
    collection do
      get :search
    end
  end

  root 'breeds#index'

  get '/about', to: 'about#index'

  resources :breed_images, only: [:index, :show] do
    collection do
      get :random
      get :search
    end
  end
end
