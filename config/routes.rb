Rails.application.routes.draw do
  resources :missions

  get "up" => "rails/health#show", as: :rails_health_check

  resources :missions

  resources :spacecrafts, only: [] do
    resources :missions, only: :index, module: :spacecrafts
  end
end
