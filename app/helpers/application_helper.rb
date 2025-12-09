# frozen_string_literal: true

module ApplicationHelper
  def safe_any?(collection)
    collection.respond_to?(:any?) && collection.any?
  end

  def render_coach_dashboard_if_coach(user) # rubocop:disable Metrics/MethodLength
    if user&.admin?
      render 'admin/dashboard'
    elsif user&.coach?
      render 'dashboard/coach_dashboard'
    elsif user.role == 'parent_user'
      render 'dashboard/parent_dashboard'
    elsif user.role == 'child_user'
      render 'dashboard/child_athlete_dashboard'
    else
      render 'dashboard/athlete_dashboard'
    end
  end

  def render_news_partial(user)
    if user&.coach?
      render 'components/coach_right_bar'
    else
      render 'components/news_bar'
    end
  end

  def role_badge_class(role) # rubocop:disable Metrics/MethodLength
    case role
    when 'admin'
      'bg-purple-100 text-purple-800'
    when 'coach'
      'bg-blue-100 text-blue-800'
    when 'athlete', 'child_user'
      'bg-green-100 text-green-800'
    when 'parent_user'
      'bg-yellow-100 text-yellow-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end

  # TasterBooking color
  def status_badge(status)
    colors = {
      'confirmed' => 'bg-green-100 text-green-800',
      'cancelled' => 'bg-red-100 text-red-800',
      'pending' => 'bg-yellow-100 text-yellow-800'
    }

    base_classes = 'px-2 inline-flex text-xs leading-5 font-semibold rounded-full'
    status_class = colors[status.to_s.downcase] || 'bg-gray-100 text-gray-800'
    content_tag(:span, status.titleize, class: "#{base_classes} #{status_class}")
  end

  def status_bg_color(status)
    case status.downcase
    when 'confirmed' then 'bg-green-50'
    when 'cancelled' then 'bg-red-50'
    when 'pending' then 'bg-yellow-50'
    else 'bg-gray-50'
    end
  end

  def status_text_color(status)
    case status.downcase
    when 'confirmed' then 'text-green-700'
    when 'cancelled' then 'text-red-700'
    when 'pending' then 'text-yellow-700'
    else 'text-gray-700'
    end
  end

  def check_icon(condition)
    if condition
      content_tag(:span, '✓', class: 'text-green-500 font-bold')
    else
      content_tag(:span, '✗', class: 'text-red-500 font-bold')
    end
  end

  def status_badge_classes(status)
    case status.downcase
    when 'confirmed' then 'bg-green-100 text-green-800'
    when 'cancelled' then 'bg-red-100 text-red-800'
    when 'pending' then 'bg-yellow-100 text-yellow-800'
    else 'bg-gray-100 text-gray-800'
    end
  end
end
