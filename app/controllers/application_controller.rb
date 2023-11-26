class ApplicationController < ActionController::API
  include Authentication

  before_action :set_paper_trail_whodunnit

  private

  # Override user for papertrail since it expects an current_user
  def user_for_paper_trail
    request.ip
  end
end
