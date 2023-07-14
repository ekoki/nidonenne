class GotUp < ApplicationRecord
  belongs_to :user

  validates :got_up, presence: true
  
  def save_got_up(user)
    current_time = Time.current.strftime("%H:%M:%S")
    if user.notification_settings.first.send_time.nil?
      return false
    else
      send_time_plus = user.notification_settings.first.send_time + 10.minutes
      send_time = send_time_plus.strftime("%H:%M:%S")
    end
    if  current_time < send_time
      GotUp.create!(user_id: user.id, got_up: true, start_time: Time.current)
    end
  end


  # https://qiita.com/Sugizou0215/items/0416c099bc03302e5a23

end