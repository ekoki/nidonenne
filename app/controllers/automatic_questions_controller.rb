class AutomaticQuestionsController < ApplicationController

  def generate
    @automatic_questions = AutomaticQuestion.order(Arel.sql('RANDOM()')).limit(3)
   end

end
