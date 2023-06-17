class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :require_login

  private

  #フレンドリーフォワーディング
  def not_authenticated
    session[:forwarding_url] = request.original_url if request.get?
    redirect_to login_url, alert: "ログインして下さい。"
  end


end
