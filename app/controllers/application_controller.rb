class ApplicationController < ActionController::API
  before_action :set_paper_trail_whodunnit
  before_action :authorize_origin!

  private

  def authorize_origin!
    # TODO: If this api is a internal, we allow only server-to-server authentication
    user_agent = "Houston::Client/"
    return if request.headers["HTTP_USER_AGENT"].include?(user_agent) || request.user_agent.include?(user_agent)

    head(:unauthorized)
  end

  # Override user for papertrail since it expects an current_user
  def user_for_paper_trail
    request.ip
  end
end
