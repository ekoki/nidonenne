class NotificationSetting < ApplicationRecord
  belongs_to :user

  validates :send_time, presence: true
  validates :user_id, uniqueness: true
  validates :notification_schedule, presence: true

  enum notification_schedule: { daily: 1, weekday: 2, weekend: 3 }
end
