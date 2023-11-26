class ApplicationController < ActionController::API
  before_action :authorize_origin!

  private

  def authorize_origin!
    # TODO: If this api is a internal, we allow only server-to-server authentication
    return if request.headers["HTTP_USER_AGENT"].include?("HoustonClient") || request.user_agent.include?("HoustonClient")

    head(:unauthorized)
  end
end
