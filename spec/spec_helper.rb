ENV['MOCK_MARKETO'] ||= "true"

Bundler.require(:default, :test)

require File.expand_path("../../lib/marko", __FILE__)
Dir[File.expand_path("../{shared,support}/*.rb", __FILE__)].each { |f| require(f) }

Cistern.formatter = Cistern::Formatter::AwesomePrint

if ENV['MOCK_MARKETO'] == "true"
  Cistern.timeout = 0
  Marko::Client.mock!
else
  Cistern.timeout = 1
end

RSpec.configure do |config|
  config.order = "random"
  config.before(:each) { Marko::Client.reset! if Marko::Client.mocking? }

  config.filter_run_excluding(Marko::Client.mocking? ? {real_only: true} : { mock_only: true })
end
