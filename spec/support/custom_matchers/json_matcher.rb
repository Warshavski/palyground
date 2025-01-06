# frozen_string_literal: true

# frozen_string_literal: true.

# Helper methods for the JSON data specs
#
RSpec::Matchers.define :look_like_json do |_expected|
  match do |actual|
    JSON.parse(actual)
  rescue JSON::ParserError
    false
  end

  failure_message do |actual|
    "\"#{actual}\" is not parsable by JSON.parse"
  end

  description do
    'Expects to be JSON parsable String'
  end
end
