class AnswerFormsController < ApplicationController

  def create
    @user = User.find(current_user.id)
    correct_answers = Question.where(user_id: current_user.id)
    @answer_forms = AnswerForm.new(user_answers)
    user_answers = user_answers
    @question = Question.new
    @questions = @user.questions
    unless @answer_forms.valid?
      render 'users/show'
      return
    end
    if @answer_forms.correct?(user_answers, correct_answers) == 3
      redirect_to schedules_index_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render 'users/show'
    end
  end

  private

  def user_answers
    params.require(:answer_form).permit("0": [:answer], "1": [:answer], "2": [:answer] )
  end

end