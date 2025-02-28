# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@chambersforsport.com'
  layout 'mailer'
end
