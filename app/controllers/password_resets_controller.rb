class PasswordResetsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    #パスワードをリセットする方法（ランダムなトークンを含むURL）を記載したメールをユーザーに送信
    @user&.deliver_reset_password_instructions!
    redirect_to login_path, notice: t('.success')
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    #ifの条件を満たすとルートパスへリダイレクトされる
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    #一時的なトークンをクリアし、パスワードを更新
    if @user.change_password(params[:user][:password])
      redirect_to login_path, notice: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end
  end


end
