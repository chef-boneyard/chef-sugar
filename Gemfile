source "https://rubygems.org"
gemspec name: "chef-sugar"

group :debug do
  gem "pry"
  gem "pry-byebug" unless Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.4")
  gem "pry-stack_explorer", "~> 0.4.0" # pin until we drop ruby < 2.6
end

group :test do
  if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.5")
    gem "chefspec", "~> 7.4.0" # supports Chef 13+ aka ruby 2.3+
    gem "chef", "~> 13" # also needed to support Ruby 2.3
  elsif Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.6")
    gem "chefspec"
    gem "chef-zero", "~> 14"
    gem "chef", "~> 15" # also needed to support Ruby 2.3
  else
    gem "chefspec"
  end
  if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.4")
    gem "rubyzip", "< 2"
  else
    gem "rubyzip"
  end
  gem "rake"
  gem "rspec"
end

group :kitchen do
  gem "kitchen-vagrant"
  gem "license-acceptance", "~> 1.0" if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.4")
  gem "test-kitchen"
end
