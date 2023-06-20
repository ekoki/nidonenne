class NotificationSetting < ApplicationRecord
  belongs_to :user

  validates :send_time, presence: true
  validates :user_id, uniqueness: true
end
