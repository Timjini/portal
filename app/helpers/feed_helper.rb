# frozen_string_literal: true

module FeedHelper
  def render_feed_by_role
    case current_user.role
    when 'admin', 'coach'
      render 'feeds/admin'
    when 'athlete', 'parent_user', 'child_user'
      render 'feeds/user_feed'
    else
      redirect_to root_path, alert: 'Access denied or role not recognized.' # rubocop:disable Rails/I18nLocaleTexts
    end
  end
end
