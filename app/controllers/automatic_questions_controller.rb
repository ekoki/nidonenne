class AutomaticQuestionsController < ApplicationController

  def generate
    frequency = params[:frequency]
    @automatic_questions = AutomaticQuestion.order(Arel.sql('RANDOM()')).limit(frequency)
  end

end
