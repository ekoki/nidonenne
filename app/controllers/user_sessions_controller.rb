class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new;end

  def create
    @user = login(params[:email], params[:password])
    if @user
      # ログインに成功したとき、もともと訪れようとしていたURLか該当がない場合には、デフォルトのURLにリダイレクト
      redirect_to session[:forwarding_url] || schedules_index_path, notice: t('.success')
      session.delete(:forwarding_url)
    else
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('.success'), status: :see_other
  end

end
