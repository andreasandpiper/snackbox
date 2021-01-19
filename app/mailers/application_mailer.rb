# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'awayte@teladochealth.com'
  layout 'mailer'
end
