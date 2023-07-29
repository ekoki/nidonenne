class LineLoginApiController < ApplicationController
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token
  protect_from_forgery :except => [:webhook]

  require 'json'
  require 'typhoeus'
  require 'securerandom'

  def new
  end

  def login

    session[:state] = SecureRandom.urlsafe_base64
    
    # ユーザーに認証と認可を要求する
    # https://developers.line.biz/ja/docs/line-login/integrate-line-login/#making-an-authorization-request

    base_authorization_url = 'https://access.line.me/oauth2/v2.1/authorize'
    response_type = 'code'
    client_id =  ENV["LINE_CHANNEL_ID"]
    redirect_uri =  CGI.escape('https://www.nidonenne.com/line_login_api/callback')
    state = session[:state]
    bot_prompt='aggressive'
    scope = 'profile%20openid' #ユーザーに付与を依頼する権限

    authorization_url = "#{base_authorization_url}?response_type=#{response_type}&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&bot_prompt=#{bot_prompt}&scope=#{scope}"
    
    redirect_to authorization_url, allow_other_host: true
    
  end

  def callback
    if session[:state] == params[:state]
      body = request.body.read

      events = client.parse_events_from(body)

      events.each { |event|
        case event
        when Line::Bot::Event::Follow
          user_id = event['source']['userId']
          LineUser.create(line_user_id: user_id, user_id: current_user.id)
        end
      }

      head :ok
      redirect_to schedules_index_path
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

end



