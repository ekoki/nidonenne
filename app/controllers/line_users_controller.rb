class LineUsersController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery except: :webhook
  require 'line/bot'  # gem 'line-bot-api'
  require 'net/http'
  require 'json'
  require 'uri'
  require 'securerandom'

  def webhook
    #JSON形式のデータからデータを取得する。
    body = request.body.read
    events = JSON.parse(body)["events"]

    events.each do |event|
      if event["type"] == "follow"
        user_id = event["source"]["userId"]
        current_user.line_users.create(line_user_id: user_id)
      end 
    end

    # HTTPステータスコード200のレスポンスを送る。ビューについては表示されない。
    head :ok
  end

end