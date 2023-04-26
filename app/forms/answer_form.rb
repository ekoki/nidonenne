class AnswerForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :answer

  validates :answer, presence: true

  def correct?(user_answers, correct_answers)
    correct_count = 0
    correct_answers.each do |correct_answer|
      user_answers&.each do |user_answer|
        if correct_answer.answer == user_answer[1][:answer]
          correct_count += 1
        end
      end
    end
    return correct_count
  end

end