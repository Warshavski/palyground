# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/vendor/ruby/'
  add_filter '/bin/'
  add_filter 'db/fixtures/development/'
  add_filter 'config/initializers'

  add_filter 'spec/factories'
  add_filter 'spec/support/shared_contexts'
  add_filter 'spec/support/helpers'
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'database_cleaner'
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'rspec-parameterized'
# Add additional requires below this line. Rails is not loaded until this point!

require 'test_prof/recipes/rspec/before_all'
require 'test_prof/recipes/rspec/let_it_be'
require 'test_prof/recipes/rspec/factory_all_stub'

require_relative 'support/shared_contexts/bullet_context'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec::Matchers.define_negated_matcher :not_change, :change
RSpec::Matchers.define_negated_matcher :not_yield_control, :yield_control

Dir[Rails.root.join('spec/support/**/*.rb')].each(&method(:require))
Dir[Rails.root.join('spec/support/helpers/*.rb')].each(&method(:require))

RSpec.configure do |config| # rubocop:disable Metrics/BlockLength
  config.include ActiveJob::TestHelper
  config.include ActiveSupport::Testing::TimeHelpers

  config.include StubEnvHelpers

  config.include FactoryBot::Syntax::Methods

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.alias_example_to 'bulletify', bullet: true

  DatabaseCleaner.url_allowlist = %w[
    postgres://postgres@localhost
    postgres://postgres:postgres@postgres:5432
    postgres://postgres:postgres@localhost:5432
  ]

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:example, :request_store) do
    RequestStore.begin!
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  config.around(:each, :use_clean_rails_memory_store_caching) do |example|
    caching_store = Rails.cache
    Rails.cache = ActiveSupport::Cache::MemoryStore.new

    example.run

    Rails.cache = caching_store
  end

  config.around(:each, :clean_elplano_redis_cache) do |example|
    redis_cache_cleanup!

    example.run

    redis_cache_cleanup!
  end

  config.around(:each, :clean_elplano_redis_sessions) do |example|
    redis_sessions_cleanup!

    example.run

    redis_sessions_cleanup!
  end
end
