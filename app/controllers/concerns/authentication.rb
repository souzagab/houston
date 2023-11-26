module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate!
  end

  def current_account
    Current.account
  end

  private

  # TODO: S2S authentication
  def authenticate!
    # f this api is a internal, we allow only server-to-server authentication
    user_agent = "Houston::Client/"
    return if request.headers["HTTP_USER_AGENT"].include?(user_agent) || request.user_agent.include?(user_agent)

    head :unauthorized
  end
end
