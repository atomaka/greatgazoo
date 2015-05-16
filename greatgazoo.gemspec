# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'great_gazoo/version'

Gem::Specification.new do |spec|
  spec.platform    = Gem::Platform::RUBY
  spec.name        = 'greatgazoo'
  spec.version     = GreatGazoo::VERSION
  spec.authors     = ['Andrew Tomaka']
  spec.email       = ['atomaka@gmail.com']
  spec.homepage    = 'http://www.atomaka.com'
  spec.summary     = %q{Remap time, often causing you more even more trouble}
  spec.description = %q{Takes a set of times and a black-out window to rewrite timestamps to be outside of the window while still being sequential}
  spec.license     = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2.0'
  spec.add_development_dependency 'pry'
end
