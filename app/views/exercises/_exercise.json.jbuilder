json.extract! exercise, :id, :name, :description, :reps, :sets, :duration_seconds, :distance_meters, :male_benchmark, :female_benchmark, :notes, :movement_patterns, :equipment, :created_at, :updated_at
json.url exercise_url(exercise, format: :json)
