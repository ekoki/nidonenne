class SchedulesController < ApplicationController
  def index
    @got_ups = GotUp.where(user_id: current_user.id)
  end

 
end
