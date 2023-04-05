class SendLineMessageJob < ApplicationJob
  queue_as :default

  def perform(*args)
    schedule = Schedule.find(args[0])
    puts 'スケジュールをお知らせします！'
    puts 'タイトル：' + schedule.title
  end
end
