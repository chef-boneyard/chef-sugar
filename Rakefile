require 'bundler/setup'
require 'bundler/gem_tasks'

require 'stove/rake_task'
desc "Publish chef-sugar v#{Chef::Sugar::VERSION} to the Community Site"
Stove::RakeTask.new(:publish) do |t|
  t.send(:options)[:version] = Chef::Sugar::VERSION
end
