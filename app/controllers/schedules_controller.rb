class SchedulesController < ApplicationController
  def index
    @events = ['たこ焼き', 'ピーマン', 'さつまいも']
  end

  def create
    # LINEメッセージを送信
    @schedule = Schedule.new(schedule_params)

    # フォーマット(HTMLやjson)ごとに処理を分けている。
    respond_to do |format|
      if @schedule.save
        # 下記1行を追加
        SendNotificationJob.set(wait_until: @schedule.start_time).perform_later(@schedule.id)
              
        format.html { redirect_to schedule_url(@schedule), notice: "Schedule was successfully created." }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

end
