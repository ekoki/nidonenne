class NotificationSetting < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  validates :send_time, presence: true
end
