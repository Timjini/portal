# app/controllers/parents/dashboard_controller.rb
module Parents
  class DashboardController < ApplicationController
    before_action :set_children, only: %i[index select_child]

    def index
      @selected_child = @children.first
      load_child_data(@selected_child)
    end

    def select_child
      @selected_child = @children.detect { |child| child.id.to_s == params[:child_id] }

      if @selected_child
        load_child_data(@selected_child)
      else
        @selected_child = @children.first
        load_child_data(@selected_child)
      end

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('progress-timeline',
                                                    partial: 'parents/dashboard/partials/progress_timeline',
                                                    locals: dashboard_locals)
        end
      end
    end

    private

    def set_children
      @children = Rails.cache.fetch("user_#{current_user.id}_children", expires_in: 10.minutes) do
        User.where(parent_id: current_user.id)
            .includes(:avatar_attachment, :athlete_profile)
            .order(:first_name)
            .to_a
      end
    end

    def load_child_data(child)
      return unless child

      cache_key = "child_#{child.id}_dashboard_data_#{child.updated_at.to_i}"

      dashboard_data = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
        {
          attendances: load_attendances(child),
          milestones: load_milestones(child),
          upcoming_events: load_upcoming_events(child),
          coach_feedback: load_coach_feedback(child)
        }
      end

      @children_attendances = dashboard_data[:attendances]
      @milestones = dashboard_data[:milestones] || []
      @upcoming_events = Array(dashboard_data[:upcoming_events]) # Ensure array
      @coach_feedback = Array(dashboard_data[:coach_feedback])   # Ensure array
    end

    def load_attendances(child)
      [AthleteAttendanceService.new(child).call]
    end

    def load_milestones(child)
      Assessment.where(athlete_id: child.id)
                .includes(:assessment_checklists)
                .order(created_at: :desc)
                .limit(5)
                .to_a
    end

    def load_upcoming_events(_child)
      [] # Return empty array instead of nil
    end

    def load_coach_feedback(_child)
      [] # Return empty array instead of nil
    end

    def dashboard_locals
      {
        milestones: @milestones || [],
        selected_child: @selected_child,
        children: @children,
        upcoming_events: @upcoming_events || [],
        coach_feedback: @coach_feedback || []
      }
    end
  end
end
