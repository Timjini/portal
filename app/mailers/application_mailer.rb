# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@club.chambersforsport.com'
  layout 'mailer'
end
