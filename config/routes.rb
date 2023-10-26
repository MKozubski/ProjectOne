Rails.application.routes.draw do
  get 'about/index'
  resources :breeds, only: [:index, :show] do
    collection do
      get :search
    end
    resources :sub_breeds, only: [:show]
  end

  root 'breeds#index'

  get '/about', to: 'about#index'
  get 'hierarchical_search/search', to: 'hierarchical_search#search', as: :hierarchical_search


  resources :breed_images, only: [:index, :show] do
    collection do
      get :random
      get :search
    end
  end
end
