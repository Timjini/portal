# frozen_string_literal: true

module Admin
  class AthleteLevelSerializer < ActiveModel::Serializer
    attributes :id, :name, :position, :description, :min_age, :max_age, :color, :active
  end
end
