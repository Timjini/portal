# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  has_many :questions # rubocop:disable Rails/HasManyOrHasOneDependent
end
