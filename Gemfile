# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# https://github.com/dry-rb/dry-validation
# Validation library with type-safe schemas and rules https://dry-rb.org/gems/dry-validation
gem 'dry-validation'

# A fast JSON parser and Object marshaller as a Ruby gem.
# https://github.com/ohler55/oj
gem 'oj'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Catch unsafe migrations in development
# https://github.com/ankane/strong_migrations
gem 'strong_migrations'

# Rack middleware for blocking & throttling
# https://github.com/kickstarter/rack-attack
gem 'rack-attack'

# Data serialization
# TODO : prefer to use fast_jsonapi
gem 'active_model_serializers', '~> 0.9.4'

# https://github.com/Netflix/fast_jsonapi
# A lightning fast JSON:API serializer for Ruby Objects.
# gem 'fast_jsonapi'

# Rack Middleware for handling Cross-Origin Resource Sharing (CORS), which makes cross-origin AJAX possible.
# https://github.com/cyu/rack-cors
gem 'rack-cors', '>= 1.0.6', require: 'rack/cors'

# Abort requests that are taking too long
# https://github.com/sharpstone/rack-timeout
gem 'rack-timeout'

# Static code analyzer and formatter. Keep your code clean.
gem 'rubocop', '~> 1.61.0', require: false
gem 'rubocop-rails', require: false
gem 'rubocop-rspec', require: false
gem 'rubocop-rake', require: false
gem 'panolint'
gem 'rubocop-discourse'
gem 'concurrent-ruby', '1.3.4'  

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # Help to kill N+1 queries and unused eager loading
  # https://github.com/flyerhzm/bullet
  gem 'bullet'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Shim to load environment variables from .env into ENV in development.
  # https://github.com/bkeepers/dotenv
  gem 'dotenv-rails'
  gem 'bundler-audit'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  # Static analysis tool which checks Ruby on Rails applications for security vulnerabilities.
  # https://github.com/presidentbeef/brakeman
  gem 'brakeman'
  gem 'listen', '~> 3.3'
  gem 'pry-rails'

  # Provide a quality report of your Ruby code.
  # https://github.com/whitesmith/rubycritic
  gem 'rubycritic', require: false
end

group :test do
  gem 'database_cleaner'

  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec_junit_formatter'
  gem 'rspec-parameterized', require: false
  gem 'rspec-rails'
  gem 'rspec-sqlimit'
  gem 'shoulda-matchers', '>= 4.0.0'
  gem 'simplecov'

  # Ruby Tests Profiling Toolbox
  # https://github.com/palkan/test-prof
  gem 'test-prof'
end
