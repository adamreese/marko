require "marko/version"

require 'addressable/uri'
require 'cistern'
require 'faraday'
require 'faraday_middleware'
require 'logger'
require 'yaml'

module Marko
  autoload :Authorization, "marko/authorization"
  autoload :Client, "marko/client"
  autoload :Logger, "marko/logger"
  autoload :Model, "marko/model"
  autoload :Response, "marko/response"

  def self.defaults
    @defaults ||= if File.exists?(File.expand_path("~/.marketo"))
                    YAML.load_file(File.expand_path("~/.marketo"))
                  else
                    {}
                  end
  end

  def self.rename_attributes(collection)
    collection['attrs'] = collection.delete('attributes') if collection.include?('attributes')
    collection
  end
end
