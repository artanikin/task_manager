source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.1"
gem "pg", "~> 0.18"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "slim-rails"
gem "bootstrap-sass", "~> 3.3.6"
gem "simple_form"
gem "carrierwave"
gem "state_machines-activerecord"
gem "responders"
gem "drape", "~> 1.0.0.beta1"

gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"

gem "faker"

group :development, :test do
  gem "pry-rails"
  gem "pry-byebug"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "database_cleaner"
  gem "spring-commands-rspec"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "rubocop", "~> 0.47.1", require: false
  gem "rubocop-rspec", require: false
  gem "bullet"
end

group :test do
  gem "rails-controller-testing"
  gem "shoulda-matchers", "~> 3.1"
  gem "capybara"
  gem "launchy"
  gem "rack_session_access"
  gem "fuubar"
  gem "state_machines_rspec"
  gem "simplecov", require: false
  gem "codeclimate-test-reporter", "~> 1.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
