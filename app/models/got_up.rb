class GotUp < ApplicationRecord
  belongs_to :user

  validates :got_up, presence: true
  
  def save(user)
    current_time = Time.current
    send_time = user.notification_settings.first.send_time
    if  current_time < send_time + 10.minutes
      GotUp.create!(user_id: user.id,got_up: true)
    end
  end

end