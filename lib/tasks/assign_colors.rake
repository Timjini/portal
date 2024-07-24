namespace :users do
  desc "Assign unique colors to all users"
  task assign_colors: :environment do
    existing_colors = User.pluck(:color)
    User.find_each do |user|
      color = user.generate_unique_color(existing_colors)
      user.update(color: color)
      existing_colors << color
    end
    puts "Colors assigned successfully!"
  end
end
