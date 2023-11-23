Rails.application.routes.draw do
  resources :missions

  get "up" => "rails/health#show", as: :rails_health_check
end
