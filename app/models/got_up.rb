class GotUp < ApplicationRecord
  belongs_to :user

  validates :got_up, presence: true
  
  def save_got_up(user)
    current_time = Time.current.strftime("%H:%M:%S").to_i
    if user.notification_settings.first.send_time.nil?
      return false
    else
      send_time = user.notification_settings.first.send_time.strftime("%H:%M:%S").to_i
    end
    if  current_time < send_time + 10.minutes
      GotUp.create!(user_id: user.id, got_up: true, start_time: Time.current)
    end
  end

  # https://qiita.com/Sugizou0215/items/0416c099bc03302e5a23

end