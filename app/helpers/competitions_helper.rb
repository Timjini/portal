# frozen_string_literal: true

module CompetitionsHelper
  def status_chip(competition) # rubocop:disable Metrics/MethodLength
    colors = {
      'active' => 'bg-green-100 text-green-800 border-green-200',
      'draft' => 'bg-blue-100 text-blue-800 border-blue-200',
      'cancelled' => 'bg-red-100 text-red-800 border-red-200'
    }

    dot_colors = {
      'active' => 'bg-green-500',
      'draft' => 'bg-blue-500',
      'cancelled' => 'bg-red-500'
    }

    status = competition.status.sub(/^status_/, '')

    content_tag :span,
                class: "inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold #{colors[status]} border" do # rubocop:disable Layout/LineLength
      concat(content_tag(:span, '', class: "w-2 h-2 #{dot_colors[status]} rounded-full mr-1.5"))
      concat(status.capitalize)
    end
  end
end
