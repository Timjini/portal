# frozen_string_literal: true

class TrainingPackage < ApplicationRecord
  STATUS = %w[draft active inactive].freeze
  PACKAGE_TYPES = %w[group_training gift_voucher camp].freeze
  TRAINING_TYPES = %w[group_training individual_training].freeze
end
