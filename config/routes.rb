Rails.application.routes.draw do
  resources :breeds, only: [:index]
  root 'breeds#index'

end
