# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "1.11.1", require: false

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails", "1.1.0"

# Devise is a flexible authentication solution for Rails based on Warden [https://github.com/heartcombo/devise].
gem "devise", "4.8.1"

# Lint your ERB or HTML files [https://github.com/Shopify/erb-lint]
gem "erb_lint", "0.1.2", require: false

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", "2.11.5"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails", "1.0.2"

# Use postgresql as the database for Active Record
gem "pg", "1.3.5"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "5.6.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "7.0.2.3"

# Forms made easy for Rails [https://github.com/heartcombo/simple_form]
gem "simple_form", "5.1.0"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails", "3.4.2"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "1.0.4"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "1.0.1"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", "2.0.4", platforms: %i[mingw mswin x64_mingw jruby]

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", "1.5.0", platforms: %i[mri mingw x64_mingw]
  # To help fixture creation [https://github.com/thoughtbot/factory_bot_rails]
  gem "factory_bot_rails", "6.2.0"
end

group :development do
  # To ensure code consistency [https://docs.rubocop.org]
  gem "rubocop", "1.28.2"
  gem "rubocop-performance", "1.13.3"
  gem "rubocop-rails", "2.14.2"
  gem "rubocop-rspec", "2.10.0"
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console", "4.2.0"
end

group :test do
  # Framework library to test our code [https://github.com/rspec/rspec-rails/]
  gem "rspec-rails", "6.0.0.rc1"
  # Provides RSpec-compatible one-liners to test common Rails functionality [https://github.com/thoughtbot/shoulda-matchers]
  gem "shoulda-matchers", "5.1.0"
end
