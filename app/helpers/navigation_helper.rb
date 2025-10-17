# app/helpers/navigation_helper.rb
module NavigationHelper
  def nav_items_for_current_user
    case current_user.role
    when 'admin'   then admin_nav_items
    when 'coach'   then coach_nav_items
    when 'athlete' then athlete_nav_items
    when 'parent_user' then parent_nav_items
    else []
    end
  end

  private

  # === ADMIN MENU ===
  def admin_nav_items # rubocop:disable Metrics/MethodLength
    [
      { name: 'Dashboard', path: admin_dashboard_index_path, icon: 'dashboard' },
      { name: 'Users', path: all_accounts_accounts_path, icon: 'users' },
      { name: 'Kpis', path: kpis_path, icon: 'data' },
      { name: 'Assessments', path: coaches_assessments_path, icon: 'assessment' },
      { name: 'Attendance', path: attendance_index_path, icon: 'attendance' },
      { name: 'Calendar', path: coach_calendar_index_path, icon: 'calendar' },
      { name: 'Time Slots', path: time_slots_path, icon: 'time_slot' },
      { name: 'Reports', path: reports_questionnaires_path, icon: 'reports' },
      {
        name: 'Content',
        path: admin_content_index_path,
        icon: 'folder',
        children: [
          { name: 'Competitions', path: admin_competitions_path, icon: 'ticket' }
        ]
      },
      { name: 'Taster Session', path: admin_taster_booking_index_path, icon: 'session' }
    ]
  end

  # === COACH MENU ===
  def coach_nav_items # rubocop:disable Metrics/MethodLength
    [
      { name: 'Dashboard', path: coaches_dashboard_index_path, icon: 'dashboard' },
      { name: 'Accounts', path: all_accounts_accounts_path, icon: 'users' },
      { name: 'Coach Calendar', path: coach_calendar_index_path, icon: 'calendar' },
      { name: 'Attendance', path: attendance_index_path, icon: 'attendance' },
      { name: 'Assessments', path: coaches_assessments_path, icon: 'assessment' },
      { name: 'Reports', path: reports_questionnaires_path, icon: 'reports' },
      {
        name: 'Content',
        path: admin_content_index_path,
        icon: 'ticket',
        children: [
          { name: 'Competitions', path: admin_competitions_path, icon: 'ticket' }
        ]
      }
    ]
  end

  # === ATHLETE MENU ===
  def athlete_nav_items
    [
      { name: 'Dashboard', path: athletes_dashboard_index_path, icon: 'dashboard' },
      { name: 'Profile', path: athlete_profile_path(current_user.athlete_profile), icon: 'user' },
      {
        name: 'Competitions',
        path: admin_competitions_path,
        icon: 'ticket'
      }
    ]
  end

  def parent_nav_items
    [
      { name: 'Dashboard', path: athletes_dashboard_index_path, icon: 'dashboard' },
      { name: 'Profile', path: athlete_profile_path(current_user.athlete_profile), icon: 'user' }
    ]
  end
end
