ALLOWED_TYPES = %w[
  image/bmp
  image/gif
  image/jpg
  image/jpeg
  image/png
  image/svg+xml
  image/tiff
  image/webp

  text/plain
  text/csv
  application/rtf
  application/pdf
].freeze

# @see https://guides.rubyonrails.org/v7.1/configuring.html#configuring-active-storage
Rails.application.config.to_prepare do
  Rails.application.configure do
    config.active_storage.routes_prefix = ENV.fetch("ACTIVE_STORAGE_PREFIX", "/b")
    config.x.upload.max_size = ENV.fetch("UPLOAD_MAX_SIZE", 5.megabytes)
    config.x.upload.allowed_types = ALLOWED_TYPES
    config.active_storage.content_types_allowed_inline = ALLOWED_TYPES
  end

  # Allow only necessary routes to be accessed without authentication
  ActiveStorage::BaseController.class_eval do
    # TODO: Understand which method of upload will be used, this is considering that the upload will be done via the sdk client
    include Authentication
  end

  # TODO: Understand which method of upload will be used and skip authentication if necessary
  #
  # ActiveStorage::Blobs::RedirectController.class_eval do
  #   skip_before_action :authenticate!
  # end
end
