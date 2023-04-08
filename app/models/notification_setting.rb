class NotificationSetting < ApplicationRecord
  belongs_to :user

  validates :send_daily, presence: true
  validates :send_time, presence: true
end
