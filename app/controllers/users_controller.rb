class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @question = Question.new
    @questions = @user.questions
    @answer_forms = AnswerForm.new
  end

  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
