# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'animenewsnetwork/version'

Gem::Specification.new do |spec|
  spec.name          = "animenewsnetwork"
  spec.version       = AnimeNewsNetwork::VERSION
  spec.authors       = ["Ryosuke IWANAGA"]
  spec.email         = ["riywo.jp@gmail.com"]
  spec.description   = %q{AnimeNewsNetwork API}
  spec.summary       = %q{AnimeNewsNetwork API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9"

  spec.add_dependency "nokogiri"
  spec.add_dependency "addressable"
  spec.add_dependency "data_validator"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
end
