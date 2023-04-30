class AnswerFormsController < ApplicationController

  def create
    @user = User.find(current_user.id)
    @correct_answers = Question.where(user_id: current_user.id)
    @user_answers = user_answer_params
    @answer_forms = AnswerForm.new(@user_answers)
    @question = Question.new
    @questions = @user.questions
    unless @answer_forms.valid?
      render 'users/show'
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


  # def user_answers
  #   answers = params[:answer_form]
  #   user_answers = {}
  #   answers.each do |answer|
  #     binding.break
  #     answer[1].each do |key, value|
  #       user_answers[key] = value
  #     end
  #     user_answers
      
  #   end
    
  # end
end