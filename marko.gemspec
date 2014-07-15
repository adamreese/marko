# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'marko/version'

Gem::Specification.new do |spec|
  spec.name          = "marko"
  spec.version       = Marko::VERSION
  spec.authors       = ["Adam Reese"]
  spec.email         = ["areese@engineyard.com"]
  spec.summary       = %q{Marketo REST API client}
  spec.description   = %q{Marketo REST API client}
  spec.homepage      = "https://github.com/adamreese/marko"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "cistern", "~> 0.6"
  spec.add_dependency "faraday", "~> 0.9.0"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "multi_json"
  spec.add_dependency "addressable"
end
