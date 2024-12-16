# frozen_string_literal: true

module Handlers
  # Handlers::Response
  #
  #   Used to represent the requested data using a serializer
  #
  module Response
    extend ActiveSupport::Concern

    # TODO : add eligible serialization keys
    OPTION_KEYS = %i[fields meta links is_collection params include].freeze

    included do
      def self.install_default_serializer(serializer) = @default_serializer = serializer

      def self.default_serializer = @default_serializer

      def render_resource(resource, options = {})
        serializer, status = process_render_options(options)
        serializer_options = process_serializer_options(options)

        data = serializer
               .new(resource, serializer_options)
               .serialized_json

        render json: data, status:
      end

      def render_meta(data)
        render json: { meta: data }, status: :ok
      end

      private

      def process_serializer_options(options)
        OPTION_KEYS.each_with_object({}) { |key, hash| hash[key] = options[key] }
      end

      def process_render_options(options)
        serializer = options[:serializer] || self.class.default_serializer
        status = options[:status] || :ok

        [serializer, status]
      end
    end
  end
end
