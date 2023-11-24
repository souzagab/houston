require "sidekiq/web"

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_background_jobs_session"

Rails.application.config.after_initialize do |app|
  app.routes.append do
    mount Sidekiq::Web => "/sidekiq"
  end
end
