class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :require_login

  # LINEから解答フォームを開く際に、自動でログインできるようにする。
  def login_with_token
    unless logged_in?
      token = params[:token]
      user = User.find_by(auth_token: token)
      if user && user.deadline
        auto_login(user)
      elsif user && !user.deadline == true
        user.ensure_auth_token
        redirect_to root_path, notice: 'トークンの有効期限が切れました'
      else user == nil
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
