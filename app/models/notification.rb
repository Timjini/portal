class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true

  enum category: {
    level: 'level',
    email: 'email',
    news: 'news',
  }
end
