# frozen_string_literal: true

# ApplicationMailer
#
#   Used as basic mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
