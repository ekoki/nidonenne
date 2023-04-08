class UserSessionsController < ApplicationController

  def new;end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to schedules_index_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new
    end
  end

end
