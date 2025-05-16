# frozen_string_literal: true

json.extract! step, :id, :athlete_level_id, :kpi_category_id, :step_number, :created_at, :updated_at
json.url step_url(step, format: :json)
