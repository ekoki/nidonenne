class Question < ApplicationRecord
  belongs_to :user

  validates :question, presence: true
  validates :answer, presence: true

  def create(question_params, current_user)
    # return false if blank?(question_params)
    question = nil
    Question.transaction do
      question_params.each do |question_form|
        question = current_user.questions.new(question_form[1])
        return question unless question.save
      end
    end
    question
  end


  private

  # def blank?(question_params)
  #   question_params.each do |question_forms|
  #     question_forms[1].each do |key, value|
  #       return true if value.blank?
  #     end
  #   end
  #   false
  # end

end


