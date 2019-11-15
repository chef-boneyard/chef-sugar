source "https://rubygems.org"
gemspec name: "chef-sugar"

group :debug do
  gem "pry"
  gem "pry-byebug"
  gem "pry-stack_explorer"
end

group :test do
  if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.5")
    gem "chefspec", "~> 7.4.0" # supports Chef 13+ aka ruby 2.3+
    gem "chef", "~> 13" # also needed to support Ruby 2.3
  else
    gem "chefspec"
  end
  if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.4")
    gem "rubyzip", "< 2"
  else
    gem "rubyzip"
   end
  gem "rake"
end

group :kitchen do
  gem "kitchen-vagrant"
  gem "test-kitchen"
end
