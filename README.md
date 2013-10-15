Chef::Sugar
================
[![Build Status](https://secure.travis-ci.org/sethvargo/chef-sugar.png?branch=master)](http://travis-ci.org/sethvargo/chef-sugar)
[![Gem Version](https://badge.fury.io/rb/chef-sugar.png)](http://badge.fury.io/rb/chef-sugar)
[![Dependency Status](https://gemnasium.com/sethvargo/chef-sugar.png)](https://gemnasium.com/sethvargo/chef-sugar)
[![Code Climate](https://codeclimate.com/github/sethvargo/chef-sugar.png)](https://codeclimate.com/github/sethvargo/chef-sugar)

Chef Sugar is a Gem & Chef Recipe that includes series of helpful sugar of the Chef core and other resources to make a cleaner, more lean recipd DSL, enforce DRY principles, and make writing Chef recipes an awesome experience!


Installation
------------
If you want to development/hack on chef-sugar, please see the Contributing.md.

If you are using Berkshelf, add `chef-sugar` to your `Berksfile`:

```ruby
cookbook 'chef-sugar'
```

Otherwise, you can use `knife` or download the tarball directly from the community site:

```ruby
knife cookbook site install chef-sugar
```


Usage
-----
In order to use Chef Sugar in your Chef Recipes, you'll first need to include it:

```ruby
include_recipe 'chef-sugar::default'
```

Alternatively you can put it in a base role or recipe and it will be included subsequently.

Requiring the Chef Sugar Gem will automatically extend the Recipe DSL, `Chef::Resource`, and `Chef::Provider` with helpful convienence methods.

### Module Method
If you are working outside of the Recipe DSL, you can use the module methods instead of the Recipe DSL. In general, the module methods have the same name as their Recipe-DSL counterparts, but require the node object as a parameter. For example:

In a Recipe:
```ruby
# cookbook/recipes/default.rb
do_something if windows?
```

In a Library as a singleton:

```ruby
# cookbook/libraries/default.rb
def only_on_windows(&block)
  yield if Chef::Sugar::PlatformFamily.windows?(@node)
end
```

In a Library as a Mixin:

```ruby
# cookbook/libraries/default.rb
include Chef::Sugar::PlatformFamily

def only_on_windows(&block)
  yield if windows?(@node)
end
```


API
---
**Note:** For the most extensive API documentation, please see the YARD documentation.

### Architecture
**Note:** Some of the architecture commands begin with an underscore (`_`) because Ruby does not permit methods to start with a numeric.

- `_64_bit?`
- `_32_bit?`

#### Examples
```ruby
execute 'build[my binary]' do
  command '...'
  not_if  { _64_bit? }
end
```

### Cloud
- `azure?`
- `cloud?`
- `ec2?`
- `eucalyptus?`
- `gce?`
- `linode?`
- `openstack?`
- `rackspace?`

#### Examples
```ruby
template '/tmp/config' do
  variables(
    # See also: best_ip_for
    ipaddress: cloud? ? node['local_ipv4'] : node['public_ipv4']
  )
end
```

### IP
- `best_ip_for` - determine the best IP address for the given "other" node, preferring local IP addresses over public ones.

#### Examples
```ruby
redis = search('node', 'role:redis').first

template '/tmp/config' do
  variables(
    ipaddress: best_ip_for(redis)
  )
end
```

### Node
- `in?` - determine if the node is in the given Chef environment.
- `includes_recipe?`

#### Examples
```ruby
credentials = if in?('production')
                Chef::EncryptedDataBag.new('...')
              else
                data_bag('...')
              end
```

```ruby
if includes_recipe?('apache2::default')
  apache_module 'my_module' do
    # ...
  end
end
```

### Platform
- `amazon_linux?`
- `centos?`
- `linux_mint?`
- `oracle_linux?`
- `redhat_enterprise_linux?`
- `scientific_linux?`
- `ubuntu?`

There are also a series of dynamically defined matchers that map named operating system release versions and comparison operators in the form "#{platform}\_#{operator}\_#{name}?". For example:

- `debian_after_squeeze?`
- `linuxmint_after_or_at_olivia?`
- `mac_os_x_lion?`
- `ubuntu_before_lucid?`
- `ubuntu_before_or_at_maverick?`

To get a full list, run the following in IRB:

```ruby
require 'chef/sugar'
puts Chef::Sugar::Platform.instance_methods
```

#### Examples
```ruby
if ubuntu?
  execute 'apt-get update'
end
```

### Platform Family
- `arch_linux?`
- `debian?`
- `fedora?`
- `freebsd?`
- `gentoo?`
- `linux?`
- `mac_os_x?`
- `openbsd?`
- `rhel?`
- `slackware?`
- `suse?`
- `windows?`

#### Examples
```ruby
node['attribute'] = if windows?
                      'C:\Foo\BarDrive'
                    else
                      '/foo/bar_drive'
                    end
```

### Ruby
**Note:** The applies to the the Ruby found at `node['languages']['ruby']`.

- `ruby_20?`
- `ruby_19?`

#### Examples
```ruby
log 'This has been known to fail on Ruby 2.0' if ruby_20?
```

### Shell
- `which`
- `dev_null`
- `installed?`
- `installed_at_version?`
- `version_for`

#### Examples
```ruby
log "Using `mongo` at `#{which('mongo')}`"

if installed?('apt')
  execute 'apt-get update'
end

execute 'install[thing]' do
  command "... 2>&1 #{dev_null}"
  not_if  { installed_at_version?('thing', node['thing']['version']) }
end

log "Skipping git install, version is at #{version_for('mongo', '-v')}"
```

### Vagrant
- `vagrant?`

#### Examples
```ruby
http_request 'http://...' do
  not_if { vagrant? }
end
```

### Filters
- `compile_time` - accepts a block of resources to run at compile time
- `before` - insert resource in the collection before the given resource
- `after` - insert resource in the collection after the given resource

#### Examples
```ruby
compile_time do
  package 'apache2'
end

# This is equivalent to
package 'apache2' do
  'apache2'
end.run_action(:install)
```

```ruby
before 'service[apache2]' do
  log 'I am before the apache 2 service fires!'
end
```

```ruby
after 'service[apache2]' do
  log 'I am after the apache 2 service fires!'
end
```


License & Authors
-----------------
- Author: Seth Vargo (sethvargo@gmail.com)

```text
Copyright 2013 Seth Vargo

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
