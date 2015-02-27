# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tourguide/version'

Gem::Specification.new do |spec|
  spec.name          = "tourguide"
  spec.version       = Tourguide::VERSION
  spec.authors       = ["Adam Carlile"]
  spec.email         = ["adam@benchmedia.co.uk"]

  spec.summary       = "Tourbus"
  spec.description   = "Tourbus"
  spec.homepage      = "http://www.github.com/boardiq/tourbus"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "sass-rails", ">= 4"
  spec.add_runtime_dependency "coffee-rails", ">= 4"
  spec.add_runtime_dependency "builder"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
