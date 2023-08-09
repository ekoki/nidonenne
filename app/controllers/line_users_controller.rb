class LineUsersController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery except: :webhook
  require 'line/bot'  # gem 'line-bot-api'
  require 'net/http'
  require 'json'
  require 'uri'
  require 'securerandom'

  # https://developers.line.biz/ja/docs/messaging-api/linking-accounts/#step-four-verifying-user-id
  def line_linkage
    user_id = current_user.id
    link_token = create_link_token(user_id)
    send_link_message(user_id, link_token)
    render plain: "Success", status: 200
  end

  def after_login
    @user = login(params[:email], params[:password])
    if @user
      redirect_to line_users_generate_nonce_path
    else
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def generate_nonce(user_id, link_token)
    nonce = SecureRandom.urlsafe_base64(16)
    Nonce.create!(nonce: nonce, user_id: user_id)
    redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{link_token}&nonce=#{nonce}"
  end

  def webhook
    # LINEからのリクエストの署名を検証する
    unless client.validate_signature(request.body.read, request.env['HTTP_X_LINE_SIGNATURE'])
      return head :bad_request
    end

    # リクエストの内容（イベント）をパースする
    events = client.parse_events_from(request.env['HTTP_X_LINE_SIGNATURE'])

    # 全てのイベントを処理する
    events.each { |event|
      case event
      when Line::Bot::Event::AccountLink
        handle_account_link(event)
      end
    }

    head :ok
  end

  private

  # 連携トークンを発行
  def create_link_token(user_id)
    channel_access_token = ENV["LINE_CHANNEL_TOKEN"]
    uri = URI.parse("https://api.line.me/v2/bot/user/#{user_id}/linkToken")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{channel_access_token}"
    
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  
    return JSON.parse(response.body)["linkToken"]
  end

  # ユーザーを連携URLにリダイレクト
  def send_link_message(user_id, link_token)
    channel_access_token = ENV["LINE_CHANNEL_TOKEN"]
    uri = URI.parse("https://api.line.me/v2/bot/message/push")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Authorization"] = "Bearer #{channel_access_token}"
    request.body = JSON.dump({
      "to" => user_id,
      "messages" => [{
        "type" => "template",
        "altText" => "Account Link",
        "template" => {
          "type" => "buttons",
          "text" => "Account Link",
          "actions" => [{
            "type" => "uri",
            "label" => "Account Link",
            # 3. 自社サービスのユーザーIDを取得するのURLを指定
            "uri" => line_users_after_login_new_url(user_id: user_id, link_token: link_token)
          }]
        }
      }]
    })
  
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end

  def handle_account_link(event)
    if event['link'].present? && event['link']['result'] == 'ok'
      nonce = event['link']['nonce']

      # nonceをもとに自社サービスのユーザーIDを取得
      user = User.find_by(nonce: nonce)

      if user
        # LINEのユーザーIDを保存
        LineUser.create!(line_user_id: event['source']['userId'], user_id: user.id)
      end
    end
  end

end