Rails.application.routes.draw do
  root "rooms#index"

  resources :rooms, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  end
end
