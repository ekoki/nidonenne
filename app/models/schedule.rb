class Schedule < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :notification_settings
end
