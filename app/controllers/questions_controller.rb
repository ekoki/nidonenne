class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new
    result = @question.save(question_params, current_user)
    if result == 'success'
      redirect_to schedules_index_path, notice: t('.success')
    else
      @amount = params[:frequency].to_i
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def question_params
    params.require(:question).permit(questions: [:question, :answer])[:questions]
  end

end
