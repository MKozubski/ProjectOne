Rails.application.routes.draw do
  resources :breeds, only: [:index]

  root 'breeds#index'

  resources :breed_images, only: [:index, :show] do
    collection do
      get :random
      get :search
    end
  end
end
