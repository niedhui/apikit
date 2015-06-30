# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apikit/version'

Gem::Specification.new do |spec|
  spec.name          = "apikit"
  spec.version       = Apikit::VERSION
  spec.authors       = ["niedhui"]
  spec.email         = ["niedhui@gmail.com"]
  spec.summary       = 'try to implement an api consumer'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sawyer',   '~> 0.6.0'
  spec.add_dependency 'wisper',   '~> 1.6.0'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
