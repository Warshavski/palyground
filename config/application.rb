# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'active_storage/engine'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Playground
  # Playground::Application
  #
  #   Used for application configuration setup
  class Application < Rails::Application
    require_relative Rails.root.join('lib/middleware/health_check')

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.eager_load_paths.push("#{config.root}/lib")

    #
    # This middleware needs to precede ActiveRecord::QueryCache and
    # other middlewares that connect to the database.
    #
    config.middleware.insert_after(Rails::Rack::Logger, ::Middleware::HealthCheck)

    #
    # Allow to access API from other domains
    #
    config.middleware.insert_before(0, Rack::Cors) do
      #
      # Cross-origin requests must not have the session cookie available
      #
      allow do
        origins '*'
        resource '/api/*',
                 credentials: false,
                 headers: :any,
                 methods: :any,
                 expose: %w[Link X-Total X-Total-Pages X-Per-Page X-Page X-Next-Page X-Prev-Page]
      end
    end

    # Configure sensitive parameters which will be filtered from the log file.
    #
    # Parameters filtered:
    #
    #   - Any parameter ending with `token`
    #   - Any parameter containing `password`
    #   - Any parameter containing `secret`
    #   - Any parameter ending with `key`
    #
    config.filter_parameters += [/token$/, /password/, /secret/, /key$/]
  end
end
