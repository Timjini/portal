# frozen_string_literal: true

class AssessmentChecklist < ApplicationRecord
  belongs_to :assessment
  belongs_to :check_list
end
