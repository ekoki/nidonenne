class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new
    @question = @question.create(question_params, current_user)
    if @question.persisted?
      redirect_to schedules_index_path, notice: t('.success')
    else
      # binding.break
      @amount = params[:frequency].to_i
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def bulk_destroy
    current_user.questions.where(id: params[:ids]).destroy_all
    redirect_to new_user_answer_form_path(current_user), notice: t('.success'), status: :see_other
  end
  
  private

  def question_params
    params.require(:question).permit(questions: [:question, :answer])[:questions]
  end

end
