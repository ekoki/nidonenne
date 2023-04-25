class AnswerFormsController < ApplicationController

  def create
    @user = User.find(current_user.id)
    @correct_answers = Question.where(user_id: current_user.id)
    @user_answers = user_answers
    if correct? == 3
      redirect_to schedules_index_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      @user = User.find(current_user.id)
      @question = Question.new
      @questions = @user.questions
      render 'users/show'
    end
  end

  private

  def user_answers
    params.require(:questions).permit("0": [:answer], "1": [:answer], "2": [:answer] )
  end

  def correct?
    correct_count = 0
    @correct_answers.each do |correct_answer|
      @user_answers.each do |user_answer|
        if correct_answer.answer == user_answer[1][:answer]
          correct_count += 1
        end
      end
    end
    return correct_count
  end
  
end






