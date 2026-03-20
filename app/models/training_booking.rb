# frozen_string_literal: true

class TrainingBooking < ApplicationRecord
  belongs_to :training_package
  after_create -> { Rails.logger.info('Congratulations, the callback has run!') }

  # belongs_to :user
end
