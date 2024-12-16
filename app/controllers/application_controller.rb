# frozen_string_literal: true

# ApplicationController
#
#   Used as base controller
#
class ApplicationController < ActionController::API
  include Handlers::Response
  include Handlers::Exception

  #
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  #
  # protect_from_forgery with: :null_session

  before_action :destroy_session!, :ensure_request_format!

  private

  def destroy_session!
    request.session_options[:skip] = true
  end

  def ensure_request_format!
    return if request.format.json?

    message = I18n.t(:'errors.messages.routes.not_found')
    render_error([{ status: 404, detail: message }], :not_found)
  end
end
