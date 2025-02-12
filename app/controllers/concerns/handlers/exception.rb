# frozen_string_literal: true

module Handlers
  # Handlers::Exception
  #
  #   Used to handle application exceptions and render appropriate json response
  #
  module Exception
    extend ActiveSupport::Concern

    included do
      # Return 500 - Internal Server Error
      #
      rescue_from StandardError do |e|
        handle_error(e, :kaboom, status: :internal_server_error, send_report: true)
      end

      # Return 404 - Not Found
      #
      rescue_from ActiveRecord::RecordNotFound do |e|
        handle_error(e, :not_found, status: :not_found)
      end

      # TODO : setup Rack timeout gem
      #
      # Return 408 - Request Timeout
      #
      # rescue_from Rack::Timeout::RequestTimeoutException do |e|
      #   handle_error(e, :timeout, status: :request_timeout, send_report: true)
      # end
    end

    private

    def handle_error(error, type, status:, send_report: false, **opts)
      log_error(error, send_report:)
        .then { |err| serializer_error(err, type, status, opts) }
        .then { |representation| render_error(representation, status) }
    end

    def log_error(error, send_report: false)
      application_trace = ActionDispatch::ExceptionWrapper
                          .new(ActiveSupport::BacktraceCleaner.new, error)
                          .application_trace

      application_trace.map! { |t| "  #{t}\n" }

      logger.error "\n#{error.class.name} (#{error.message}):\n#{application_trace.join}"

      error.tap { |ex| Rollbar.error(ex) if send_report }
    end

    def serializer_error(error, type, status, opts = {})
      ::Errors::RequestErrorsSerializer.new(error, type).serialize(status, opts)
    end

    def render_error(representation, status)
      render json: representation, status:
    end
  end
end
