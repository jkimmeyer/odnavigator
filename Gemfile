source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.1.2'

# Backend
gem 'pg', '~> 0.18'
gem 'bcrypt', '~> 3.1.7'
gem 'puma', '~> 3.7'
gem 'httparty' #Use HTTP-Party instead of excon for performance reason
gem 'json'
gem 'enumerize'
gem 'sidekiq'
gem 'rack-cors', :require => 'rack/cors'
gem 'ckan', '~> 0.0.3'
gem 'clockwork', '~> 2.0', '>= 2.0.3'


# Frontend
gem 'hamlit-rails'
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks'
gem 'jbuilder', '~> 2.5'
gem 'simple_form'
gem 'easy_table'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'bootstrap-sass', '~> 3.3.7'

# Javascript
source 'https://rails-assets.org' do
  gem 'rails-assets-leaflet'
  gem 'rails-assets-leaflet.markercluster'
end

# Deployment
gem 'dotenv-rails'
gem 'therubyracer', platforms: :ruby

# Documentation
group :development do
  gem 'sdoc', group: :doc
  gem 'rails-erd', require: false
  gem 'license_finder', require: false
end

# Data APIs
# Authentication / Authorization

# Testing
group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :development do
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
end

group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'capybara-screenshot'
  gem 'poltergeist'
  gem 'faker'
  gem 'database_cleaner'
end

# Debugging
group :development, :test do
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
end

group :development do
  gem 'web-console'
  gem 'awesome_print'
  gem 'pre-commit', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
end

# Monitoring
gem 'sentry-raven'
gem 'newrelic_rpm'

# Misc
group :development, :test do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
