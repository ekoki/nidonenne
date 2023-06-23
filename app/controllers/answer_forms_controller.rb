class AnswerFormsController < ApplicationController
  skip_before_action :require_login, only: [:new]
  before_action :login_with_token, only: [:new]
  before_action :require_login, only: [:new]

  def new
    # whereメソッドを実施することにより、配列で、qustionのレコードが格納される。
    @questions = Question.where(user_id: params[:user_id])
    @answer_form = AnswerForm.new
    @user = User.find_by(id: current_user.id)
  end

  def create
    @user = User.find(current_user.id)
    @correct_answers = Question.where(user_id: current_user.id)
    @answer_form = AnswerForm.new
    @questions = current_user.questions
    if @answer_form.correct?(user_answer_params, @correct_answers) == 3
      @got_up = GotUp.new
      @got_up.save(@user)
      redirect_to schedules_index_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_answer_params
    params.require(:answer_form).permit(:answer0, :answer1, :answer2)
  end



end