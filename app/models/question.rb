class Question < ApplicationRecord
  belongs_to :user

  validates :question, presence: true
  validates :answer, presence: true

  def save(question_params, current_user)
    Question.transaction do
      question_params.each do |question_form|
        question = current_user.questions.create!(question_form[1])
      end
    end
      return 'success'
    rescue => e
      return false
  end
end


