class LineUsersController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery except: :line_linkage
  require 'line/bot'  # gem 'line-bot-api'
  require 'net/http'
  require 'json'
  require 'uri'
  require 'securerandom'

  def new;end

  def line_linkage
    line_user_id = webhook
    link_token = create_link_token(line_user_id)
    send_link_message(line_user_id, link_token)
    render plain: "Success", status: 200
  end

  def after_login_new
    @link_token = params[:link_token] 
  end

  def after_login
    @user = login(params[:email], params[:password])
    if @user
      redirect_to line_users_generate_nonce_path(link_token: params[:link_token]), notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def generate_nonce
    user_id = current_user.id
    nonce = SecureRandom.base64(16)
    
    # ここでnonceとuser_idを保存。
    Nonce.create!(user_id: user_id, nonce: nonce)
    link_token = params[:link_token]
    redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{link_token}&nonce=#{nonce}", allow_other_host: true
  end

  private

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
        return user_id if user_id
      
      when Line::Bot::Event::AccountLink
        handle_account_link(event)
      end
    }
    
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

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
    request.body = JSON.generate({
      to: user_id,
      messages: [{
        type: "template",
        altText: "ご登録ありがとうございます！下記よりログインをお願いします",
        template: {
          type: "buttons",
          text: "ご登録ありがとうございます！下記よりログインをお願いします",
          actions: [{
            type: "uri",
            label: "ログイン",
            # 3. 自社サービスのユーザーIDを取得するURLを指定
            uri: line_users_after_login_new_url(user_id: user_id, link_token: link_token)
          }]
        }
      }]
    })

    # リクエストを実行
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

  end

  def handle_account_link(event)
    result = event['link']['result'] # "ok" または "failed"
    nonce = event['link']['nonce']   # アカウント連携時に生成されたnonce
    line_user_id = event['link']['userId']

    # resultが"ok"の場合、ユーザーのアカウント連携が成功しています。
    if result == "ok"
      user = Nonce.find_by(nonce: nonce)
      LineUser.create!(user_id: user.id, line_user_id: line_user_id)
    else
      redirect_to root_path, notice: 'アカウント連携に失敗しました'
    end
  end


end