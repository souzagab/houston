class ApplicationController < ActionController::API
  before_action :authorize_origin!

  private

  def authorize_origin!
    # TODO: If this api is a internal, we allow only server-to-server authentication
    user_agent = "Houston::Client/"
    return if request.headers["HTTP_USER_AGENT"].include?(user_agent) || request.user_agent.include?(user_agent)

    head(:unauthorized)
  end
end
