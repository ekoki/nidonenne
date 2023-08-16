class SchedulesController < ApplicationController
  def index
    @got_ups = GotUp.where(user_id: current_user.id)
    @notification = current_user.notification_settings.first
  end

 
end
