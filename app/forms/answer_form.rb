class AnswerForm
  include ActiveModel::Model

  attr_accessor :answer

  validates :answer, presence: true

  def correct?
    question.answer == answer
  end
  
end