class AnswerFormsController < ApplicationController
  skip_before_action :require_login, only: [:new]
  before_action :login_with_token, only: [:new]
  before_action :require_login, only: [:new]

  def new
    # whereメソッドを実施することにより、配列で、qustionのレコードが格納される。
    @questions = Question.where(user_id: params[:user_id])
    @question = Question.new
    @answer_form = AnswerForm.new
    @user = User.find_by(id: params[:user_id])
  end

  def create
    @user = User.find(current_user.id)
    @correct_answers = Question.where(user_id: current_user.id)
    @user_answers = user_answer_params
    @answer_forms = AnswerForm.new(@user_answers)
    @question = Question.new
    @questions = @user.questions
    unless @answer_forms.valid?
      render 'answer_forms/new'
      return
    end
    if @answer_forms.correct?(@user_answers, @correct_answers) == 3
      redirect_to schedules_index_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render 'users/show'
    end
  end

  private

  def user_answer_params
    params.require(:answer_form).permit(:answer0, :answer1, :answer2)
  end

  def login_with_token
    unless logged_in?
      if params[:token]
        token = params[:token]
        user = User.find_by(auth_token: token)
        user.ensure_auth_token
        auto_login(user)
      end
    end
  end

end