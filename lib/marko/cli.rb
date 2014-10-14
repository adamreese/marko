require 'awesome_print'
require 'pry'
require 'thor'

Cistern.formatter = Cistern::Formatter::AwesomePrint

class Marko::CLI < Thor

  desc 'console', 'open a console with a client'
  def console
    pry.start
  end

  desc 'version', 'Show the Marko version'
  map %w(-v --version) => :version
  def version
    STDOUT.puts "Marko version #{ ::Marko::VERSION }"
  end

  private

  def client
    @client ||= Marko::Client.new(logger: Logger.new(STDOUT))
  end
end
