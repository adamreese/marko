module ClientHelper
  def create_client(options={})

    options.merge!(logger: Logger.new(STDOUT)) if ENV['VERBOSE']

    Marko::Client.new(options)
  end
end

RSpec.configure do |config|
  config.include(ClientHelper)
end

