class Schedule < ApplicationRecord
  belongs_to :user
  has_many :notification_settings
end
