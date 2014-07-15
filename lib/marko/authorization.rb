class Marko::Authorization < Faraday::Response::Middleware
  attr_reader :token

  def initialize(app, token)
    super(app)
    @token = token
  end

  def call(env)
    env[:request_headers]["Authorization"] = "Bearer #{token}"

    super
  end
end
