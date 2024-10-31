# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@devminds.cloud'
  layout 'mailer'
end
