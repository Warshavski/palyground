# frozen_string_literal: true

# ApplicationSerializer
#
#   Used as basic class for response serialization
class ApplicationSerializer < ActiveModel::Serializer
  delegate :serialized_json, to: :as_json
end
