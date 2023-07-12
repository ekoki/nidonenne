class NotificationSetting < ApplicationRecord
  belongs_to :user

  validates :send_time, presence: true
  validates :user_id, uniqueness: true
  validates :user_id, presence: true

  enum notification_schedule: { not_setting: 0, daily: 1, weekday: 2, weekend: 3 }

  scope :notification_daily_within_one_hour, -> { where('send_time > ? AND send_time <= ? AND notification_schedule = ?', Time.current, 1.hour.from_now, NotificationSetting.notification_schedules['daily']) }
  scope :notification_weekday_within_one_hour, -> { where('send_time > ? AND send_time <= ? AND notification_schedule = ?', Time.current, 1.hour.from_now, NotificationSetting.notification_schedules['weekday']) }
  scope :notification_weekend_within_one_hour, -> { where('send_time > ? AND send_time <= ? AND notification_schedule = ?', Time.current, 1.hour.from_now, NotificationSetting.notification_schedules['weekend']) }
end
