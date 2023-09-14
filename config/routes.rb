Rails.application.routes.draw do
  resources :breeds, only: [:index]
  resources :breed_images, only: [:index, :show]

  root 'breeds#index'
  get 'breed_images/random', to: 'breed_images#random', as: 'random_breed_images'
  resources :breed_images, only: [:index, :show] do
    collection do
      get :random
    end
  end

end
