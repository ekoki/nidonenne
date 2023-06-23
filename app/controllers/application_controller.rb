class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :require_login

  # LINEから解答フォームを開く際に、自動でログインできるようにする。
  def login_with_token
    unless logged_in?
      if params[:token]
        token = params[:token]
        user = User.find_by(auth_token: token)
        if user&.ensure_auth_token
          redirect_to schedules_index_path, notice: 'トークンの有効期限が切れました。'    
        else
          auto_login(user)
        end
      end
    end
  end

  #フレンドリーフォワーディング
  def not_authenticated
    session[:forwarding_url] = request.original_url if request.get?
    redirect_to login_url, alert: "ログインして下さい。"
  end


end
