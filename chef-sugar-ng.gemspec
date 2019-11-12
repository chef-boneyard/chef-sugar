# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chef/sugar/version'

Gem::Specification.new do |spec|
  spec.name          = 'chef-sugar-ng'
  spec.version       = Chef::Sugar::VERSION
  spec.authors       = ['Seth Vargo']
  spec.email         = ['sethvargo@gmail.com']
  spec.description   = 'A series of helpful sugar of the Chef core and ' \
                       'other resources to make a cleaner, more lean recipe ' \
                       'DSL, enforce DRY principles, and make writing Chef '  \
                       'recipes an awesome experience!'
  spec.summary       = 'A collection of helper methods and modules that '     \
                       'make working with Chef recipes awesome.'
  spec.homepage      = 'https://github.com/chef/chef-sugar'
  spec.license       = 'Apache-2.0'

  spec.required_ruby_version = '>= 2.3'

  spec.files         = %w{LICENSE} + Dir.glob("lib/**/*", File::FNM_DOTMATCH).reject { |f| File.directory?(f) }
  spec.require_paths = ['lib']
end
