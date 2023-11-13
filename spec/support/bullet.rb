RSpec.configure do |config|
  config.around do |example|
    disable_bullet_required = example.metadata[:skip_bullet]

    Bullet.enable = false if disable_bullet_required

    example.run

    Bullet.enable = true if disable_bullet_required
  end
end
