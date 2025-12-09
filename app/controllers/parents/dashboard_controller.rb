# frozen_string_literal: true

module Parents
  class DashboardController < ApplicationController
    def index
      @children = User.where(parent_id: current_user.id)
                      .includes(:avatar_attachment, :athlete_profile, :attendances)
      # default to first child
      @selected_child = @children.first
      load_child_data(@selected_child)
    end

    def select_child # rubocop:disable Metrics/MethodLength
      @children = User.where(parent_id: current_user.id)
      @selected_child = User.find(params[:child_id])
      load_child_data(@selected_child)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('progress-timeline',
                                                    partial: 'parents/dashboard/partials/progress_timeline',
                                                    locals: { milestones: @milestones, selected_child: @selected_child,
                                                              children: @children })
        end
      end
    end

    private

    def load_child_data(child)
      @children_attendances = [AthleteAttendanceService.new(child).call]

      @milestones = Assessment.where(athlete_id: child.id)
                              .includes(:assessment_checklists)
                              .order(created_at: :desc)
                              .limit(5)

      # @upcoming_events = ::Event.where(athlete_id: child.id)
      #                           .order(date: :asc)
      #                           .limit(5)

      # @coach_feedback = ::Feedback.where(athlete_id: child.id)
      #                             .order(created_at: :desc)
      #                             .limit(5)
    end
  end
end
