class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    question_forms = question_params
    @question = Question.new
    if @question.question_saves(question_forms, current_user)
      redirect_to schedules_index_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new
    end
      
  end
  
  private

  def question_params
    params.require(:question).permit(questions: [:question, :answer])[:questions]
  end

end
