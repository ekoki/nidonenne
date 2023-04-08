class Schedule < ApplicationRecord
  belongs_to :user

  validates :wake_up_time, presence: true
  validates :bedtime, presence: true

end
