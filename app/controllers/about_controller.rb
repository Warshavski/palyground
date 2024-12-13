# frozen_string_literal: true

# AboutController
#
#   Used to represent core information about API
#
class AboutController < ApplicationController
  def show
    api_info = {
      version: PlaygroundApp.version,
      revision: PlaygroundApp.revision
    }

    render json: { data: api_info }, status: :ok
  end
end
