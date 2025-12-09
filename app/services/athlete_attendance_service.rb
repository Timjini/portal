# frozen_string_literal: true

class AthleteAttendanceService
  include ActionView::Helpers::DateHelper

  def initialize(athlete)
    @athlete = athlete
  end

  def call
    grouped_attendance.map { |user_id, records| build_stats(user_id, records) }
  end

  private

  def grouped_attendance
    Attendance.includes(:user).group_by(&:user_id)
  end

  def build_stats(user_id, records)
    user = records.first.user

    {
      id: user_id,
      child_name: user_name(user),
      percentage: attendance_percentage(records),
      percentage_class: percentage_css(attendance_percentage(records)),
      attendance_bars: build_bars(records),
      missed_sessions: missed_count(records),
      last_missed: last_missed_text(records)
    }
  end

  def user_name(user)
    user.full_name || user.name
  end

  def total_sessions(records)
    records.size
  end

  def attended_count(records)
    records.count { |r| r.status == 'present' }
  end

  def missed_count(records)
    records.count { |r| r.status == 'absent' }
  end

  def attendance_percentage(records)
    return 0 if total_sessions(records).zero?

    ((attended_count(records).to_f / total_sessions(records)) * 100).round
  end

  def percentage_css(percent)
    return 'text-green-600' if percent >= 80
    return 'text-amber-600' if percent >= 50

    'text-red-600'
  end

  def build_bars(records)
    records.map do |rec|
      { class: rec.status == 'present' ? 'bg-green-500' : 'bg-red-500' }
    end
  end

  def last_missed_record(records)
    records.select { |r| r.status == 'absent' }.max_by(&:attended_at)
  end

  def last_missed_text(records)
    record = last_missed_record(records)
    record ? "#{time_ago_in_words(record.attended_at)} ago" : nil
  end
end
