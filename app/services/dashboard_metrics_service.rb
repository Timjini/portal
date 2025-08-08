# frozen_string_literal: true

# app/services/dashboard_metrics_service.rb
class DashboardMetricsService
  def initialize(time_range = '7d')
    @time_range = time_range
    @end_date = Date.current
    @start_date = calculate_start_date(time_range)
  end

  def platform_activity
    {
      daily_logins: daily_logins,
      assessments_per_day: assessments_per_day,
      feedback_sent: feedback_sent,
      activity_data: activity_data,
      login_trend: login_trend,
      assessment_trend: assessment_trend,
      feedback_trend: feedback_trend
    }
  end

  private

  def calculate_start_date(range)
    case range
    when '7d' then @end_date - 7.days
    when '30d' then @end_date - 30.days
    when 'quarter' then @end_date - 3.months
    else @end_date - 7.days
    end
  end

  def daily_logins
    UserLogin.where(created_at: @start_date..@end_date)
             .group_by_day(:created_at)
             .count
             .values
             .then { |vals| vals.sum / vals.size.to_f }
             .round(1)
  rescue StandardError
    nil
  end

  def assessments_per_day
    Assessment.where(completed_at: @start_date..@end_date)
              .group_by_day(:completed_at)
              .count
              .values
              .then { |vals| vals.sum / vals.size.to_f }
              .round(1)
  rescue StandardError
    nil
  end

  def feedback_sent
    Feedback.where(created_at: @start_date..@end_date)
            .group_by_day(:created_at)
            .count
            .values
            .then { |vals| vals.sum / vals.size.to_f }
            .round(1)
  rescue StandardError
    nil
  end

  def activity_data
    {
      logins: UserLogin.where(created_at: @start_date..@end_date).group_by_day(:created_at).count,
      assessments: Assessment.where(completed_at: @start_date..@end_date).group_by_day(:completed_at).count,
      feedback: Feedback.where(created_at: @start_date..@end_date).group_by_day(:created_at).count
    }
  rescue StandardError
    nil
  end

  def login_trend
    calculate_trend(UserLogin, :created_at)
  end

  def assessment_trend
    calculate_trend(Assessment, :completed_at)
  end

  def feedback_trend
    calculate_trend(Feedback, :created_at)
  end

  def calculate_trend(model, date_column)
    current_period = model.where(date_column => @start_date..@end_date).count
    previous_period = model.where(date_column => (@start_date - (@end_date - @start_date))..@start_date).count

    return 0 if previous_period.zero?

    ((current_period - previous_period).to_f / previous_period * 100).round
  rescue StandardError
    0
  end
end
