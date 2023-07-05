class AutomaticQuestionsController < ApplicationController

  def generate
    @amount = params[:frequency]
    @automatic_questions = AutomaticQuestion.order(Arel.sql('RANDOM()')).limit(@amount)
  end

end
