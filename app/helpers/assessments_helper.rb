# frozen_string_literal: true

module AssessmentsHelper
  def recommendation_icon(recommendation)
    case recommendation
    when 'ready' then 'fas fa-check-circle text-green-600'
    when 'practice' then 'fas fa-sync-alt text-yellow-600'
    when 'repeat' then 'fas fa-undo text-red-600'
    else 'fas fa-question-circle text-gray-600'
    end
  end

  def recommendation_label(recommendation)
    case recommendation
    when 'ready' then 'Ready for next step'
    when 'practice' then 'Needs more practice'
    when 'repeat' then 'Repeat current step'
    else 'Unknown recommendation'
    end
  end
end
