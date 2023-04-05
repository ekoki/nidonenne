class SchedulesController < ApplicationController
  def index
  end

  def create
    # LINEメッセージを送信
    SendLineMessageJob.set(wait_until: @schedule.wake_up_time).perform_later(@schedule.id)
  end
end
