name             'chef-sugar'
maintainer       'Chef Software, Inc'
maintainer_email 'cookbooks@chef.io'
license          'Apache-2.0'
description      'Installs chef-sugar. Please see the chef-sugar Ruby gem for more information.'
long_description <<-EOH
Chef Sugar is a Gem & Chef Recipe that includes series of helpful syntactic
sugars on top of the Chef core and other resources to make a cleaner, more lean
recipe DSL, enforce DRY principles, and make writing Chef recipes an awesome and
fun experience!

For the most up-to-date information and documentation, please visit the [Chef
Sugar project page on GitHub](https://github.com/chef/chef-sugar).
EOH

version '5.1.12'

supports     'any'
issues_url   'https://github.com/chef/chef-sugar/issues'
source_url   'https://github.com/chef/chef-sugar'
chef_version '>= 13.0'
gem          'chef-sugar'
