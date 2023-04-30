class AnswerForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :answer0
  attribute :answer1
  attribute :answer2
  attribute :questions

  validates :answer0, presence: true
  validates :answer1, presence: true
  validates :answer2, presence: true

  def correct?(user_answers, correct_answers)
    correct_count = 0
    correct_answers.each do |correct_answer|
      user_answers.each do |key, value|
        if correct_answer.answer == value
          correct_count += 1
        end
      end
    end
    return correct_count
  end

end