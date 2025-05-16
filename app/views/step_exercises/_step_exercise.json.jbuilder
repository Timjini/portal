# frozen_string_literal: true

json.extract! step_exercise, :id, :step_id, :exercise_id, :reps, :sets, :duration_seconds, :distance_meters,
              :created_at, :updated_at
json.url step_exercise_url(step_exercise, format: :json)
