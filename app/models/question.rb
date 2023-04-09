class Question < ApplicationRecord
  belongs_to :user

  validates :question, presence: true, length: { maximum: 30 }
  validates :answer, presence: true, length: { maximum: 30 }

  
  def question_save(questions, current_user)
    questions.each do |question|
      current_user.questions.create(question[1])
    end
  end

end
