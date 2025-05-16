class Admin::AthleteLevelSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :description, :min_age, :max_age, :color, :active
end
