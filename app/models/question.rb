class Question < ApplicationRecord
  belongs_to :user

  validates :question, presence: true
  validates :answer, presence: true

  def save(question_params, current_user)
    return false if blank?(question_params)
    Question.transaction do
      question_params.each do |question_form|
        question = current_user.questions.create!(question_form[1])
      end
    end
    return 'success'
  end


  private

  def blank?(question_params)
    question_params.each do |question_forms|
      question_forms[1].each do |key, value|
        return true if value.blank?
      end
    end
    false
  end

end


