class LineUsersController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'

  def create
    # webhookアクションのCSRFトークン認証を無効
    protect_from_forgery :except => [:webhook]
    webhook
  end


  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def webhook
    body = request.body.read

    #LINEからリクエスト行に含められて送られる。下記により、本当にLINEからの通信であるかを確認している。
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request and return
    end

    events = client.parse_events_from(body)

    events.each { |event|
      case event
      when Line::Bot::Event::Follow
        user_id = event['source']['userId']
        LineUser.create(line_user_id: user_id, user_id: current_user.id)
      end
    }

    head :ok
  end

end