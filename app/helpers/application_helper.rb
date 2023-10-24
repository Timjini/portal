module ApplicationHelper

    def render_coach_dashboard_if_coach(user)
        if user&.coach?
            render 'dashboard/coach_dashboard'
        else
            render 'dashboard/athlete_dashboard'
        end
    end
end
