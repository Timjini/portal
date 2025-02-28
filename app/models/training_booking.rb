# frozen_string_literal: true

class TrainingBooking < ApplicationRecord
  belongs_to :training_package
  # belongs_to :user
end
