Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  mount Sidekiq::Web => "/sidekiq"

  resources :missions

  resources :spacecrafts, only: [] do
    resources :missions, only: :index, module: :spacecrafts
  end
end
