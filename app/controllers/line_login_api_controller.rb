class LineLoginApiController < ApplicationController
  skip_before_action :require_login

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
    # redirect_uri =  CGI.escape('https://9171-126-227-130-93.ngrok-free.app/line_login_api/callback')
    redirect_uri = CGI.escape(line_login_api_callback_url)
    state = session[:state]
    bot_prompt='aggressive'
    scope = 'profile%20openid' #ユーザーに付与を依頼する権限
    authorization_url = "#{base_authorization_url}?response_type=#{response_type}&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&bot_prompt=#{bot_prompt}&scope=#{scope}"
    
    redirect_to authorization_url, allow_other_host: true
    
  end

  def callback
    if session[:state] == params[:state]
      redirect_to schedules_index_path, notice: 'LINEログインに成功しました'
    else
      logout
      redirect_to login_path, notice: 'ログアウトしました'
    end

  end

end



