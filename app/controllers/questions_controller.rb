class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new
    result = @question.question_saves(question_params, current_user)
    if result == 'success'
      redirect_to schedules_index_path, notice: t('.success')
    else
      flash.now[:alert] = result
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def question_params
    params.require(:question).permit(questions: [:question, :answer])[:questions]
  end

end
