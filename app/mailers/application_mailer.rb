# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("CONTACT_EMAIL")
  layout 'mailer'
end
