# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'acts_as_stripped/version'

Gem::Specification.new do |s|
  s.name = 'acts_as_stripped'
  s.version = ActsAsStripped::VERSION
  s.authors = ['Ryan Sonnek']
  s.email = 'ryan.sonnek@gmail.com'
  s.homepage = 'http://github.com/wireframe/acts_as_stripped'
  s.summary = 'strip whitespace from string attributes'
  s.description = ' ActiveRecord Extension to strip whitespace from attributes before saving values '

  s.add_runtime_dependency 'activerecord', ['>= 2.0']
  s.add_development_dependency 'rspec', ['>= 2.5.0']
  s.add_development_dependency('sqlite3-ruby', ['~> 1.3.2'])
  s.add_development_dependency 'rake'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
