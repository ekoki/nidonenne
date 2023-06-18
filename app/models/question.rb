class Question < ApplicationRecord
  belongs_to :user

  validates :question, presence: true
  validates :answer, presence: true

  
  def question_saves(question_forms, current_user)
    #questionsは#<ActionController::Parameters {"0"=>#<ActionController::Parameters {"question"=>"dog", "answer"=>"犬"} permitted: true>, "1"=>#<ActionController::Parameters {"question"=>"cat", "answer"=>"猫"} permitted: true>, "2"=>#<ActionController::Parameters {"question"=>"cup", "answer"=>"カップ"} permitted: true>} permitted: true>が格納されている。
    question_forms.each do |question_form|
      #questionは["0", #<ActionController::Parameters {"question"=>"dog", "answer"=>"犬"} permitted: true>]になる
      question = current_user.questions.create!(question_form[1])
      set_time = question.created_at + 1.minute
      DestroyQuestionsJob.set(wait_until: set_time).perform_later(question.id)
    end
  end

end