# frozen_string_literal: true

module ApplicationHelper
  def render_coach_dashboard_if_coach(user) # rubocop:disable Metrics/MethodLength
    if user&.admin?
      render 'dashboard/admin_dashboard'
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
end
