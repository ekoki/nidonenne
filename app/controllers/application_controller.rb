class ApplicationController < ActionController::Base
  before_action :require_login
  skip_forgery_protection
  # LINEから解答フォームを開く際に、自動でログインできるようにする。
  def login_with_token
    unless logged_in?
      token = params[:token]
      user = User.find_by(auth_token: token)
      if user && user.deadline
        auto_login(user)
      elsif user && user.deadline.nil?
        user.ensure_auth_token
        redirect_to root_path, notice: 'トークンの有効期限が切れました。ログインをお願いします'
      else user.nil?
        nil_user = User.find(params[:user_id])
        nil_user.ensure_auth_token
        redirect_to root_path, notice: 'ログインをお願いします'
      end
    end
  end

  #フレンドリーフォワーディング
  def not_authenticated
    session[:forwarding_url] = request.original_url if request.get?
    redirect_to login_url, alert: "ログインして下さい。"
  end


end
