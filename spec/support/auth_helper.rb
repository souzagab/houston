module AuthTestHelper

  def authorize_origin
    allow_any_instance_of(ApplicationController).to receive(:authenticate!).and_return(true) # rubocop:disable RSpec/AnyInstance
    # TODO: Add user agent to requests
    # @request.headers["HTTP_USER_AGENT"] = "HoustonClient"
  end
end

RSpec.configure do |config|
  config.include AuthTestHelper, type: :request
  config.include AuthTestHelper, type: :controller
end
