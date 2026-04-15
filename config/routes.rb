Rails.application.routes.draw do
  get 'messages/create'
  root "rooms#index"

  resources :rooms, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  end
end
