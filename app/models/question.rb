class Question < ApplicationRecord
  belongs_to :user

  validates :question, presence: true
  validates :answer, presence: true

  
  def question_saves(question_forms, current_user)
    #questions=#<ActionController::Parameters {"0"=>#<ActionController::Parameters {"question"=>"dog", "answer"=>"犬"} permitted: true>, "1"=>#<ActionController::Parameters {"question"=>"cat", "answer"=>"猫"} permitted: true>, "2"=>#<ActionController::Parameters {"question"=>"cup", "answer"=>"カップ"} permitted: true>} permitted: true>が格納されている。
    question_forms.each do |question_form|
      #question=["0", #<ActionController::Parameters {"question"=>"dog", "answer"=>"犬"} permitted: true>]になる
      current_user.questions.create!(question_form[1])
    end
  end

end