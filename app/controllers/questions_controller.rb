class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    questions = question_params
    @question = Question.new
    if @question.question_save(questions, current_user)
      redirect_to root_path, notice: t('.success')
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
