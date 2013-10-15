#
# Cookbook Name:: chef-sugar
# Recipe:: development
#
# Copyright 2013, Seth Vargo <sethvargo@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This recipe is only meant for use when developing Chef Sugar.
#

execute('apt-get update') do
  only_if { Time.now.to_i - 86400 > `stat -c %Y /var/cache/apt/`.to_i }
end.run_action(:run)

[
  'build-essential',
  'libxslt-dev',
  'libxml2-dev',
  'git'
].each do |name|
  package(name) do
    action :nothing
  end.run_action(:install)
end

execute('gem update bundler') do
  action :nothing
  not_if { `bundle -v`.strip.gsub(/[^0-9\.]/, '').to_f >= 1.3 }
end.run_action(:run)

execute 'bundle[chef-sugar]' do
  cwd     '/gem'
  command 'bundle install --path vendor'
  not_if  'bundle check --gemfile /gem/Gemfile'
  action  :nothing
end.run_action(:run)

execute 'build[chef-sugar]' do
  cwd     '/gem'
  command 'bundle exec rake build'
  action  :nothing
end.run_action(:run)

sugar = chef_gem('chef-sugar') do
  source '/gem/pkg/chef-sugar-1.0.0.gem'
  action :nothing
end

sugar.run_action(:remove)
sugar.run_action(:install)

require 'chef/sugar'
