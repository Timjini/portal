module ApplicationHelper

   def render_coach_dashboard_if_coach(user)
        if user&.coach?
            render 'dashboard/coach_dashboard'
        elsif user.role == 'athlete_parent'
            render 'dashboard/parent_dashboard'
        elsif user.role == 'child_athlete'
            render 'dashboard/child_athlete_dashboard'
        else
            render 'dashboard/athlete_dashboard'
        end
    end
end
