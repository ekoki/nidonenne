class AnswerForm
  include ActiveModel::Model

  attr_accessor :answer

  validates :answer, presence: true


end