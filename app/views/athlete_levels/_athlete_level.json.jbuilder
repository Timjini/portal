# frozen_string_literal: true

json.extract! athlete_level, :id, :name, :position, :description, :min_age, :max_age, :color, :active, :created_at,
              :updated_at
json.url athlete_level_url(athlete_level, format: :json)
