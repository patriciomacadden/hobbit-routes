# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hobbit/routes/version'

Gem::Specification.new do |spec|
  spec.name          = 'hobbit-routes'
  spec.version       = Hobbit::Routes::VERSION
  spec.authors       = ['Patricio Mac Adden']
  spec.email         = ['patriciomacadden@gmail.com']
  spec.description   = %q{Hobbit with routes! (A proof of concept)}
  spec.summary       = %q{Hobbit with routes! (A proof of concept)}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'hobbit'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rack'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rake'

  spec.add_runtime_dependency 'hobbit'
end
