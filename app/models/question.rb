class Question < ApplicationRecord
  belongs_to :user

  validates :question, presence: true
  validates :answer, presence: true

  def question_saves(question_forms, current_user)
    if self.class.questions_empty?(question_forms)
      return '全ての問題及び解答の記入をお願いします。'
    elsif self.class.questions_count(current_user)
      return '問題及び解答は1日3問のみ登録できます。'
    else
      self.class.questions_save(question_forms, current_user)
      return 'success'
    end
  end

  def self.questions_empty?(question_forms)
    question_forms.each_value do |question_form|
      if question_form['question'].empty? || question_form['answer'].empty?
        return true
      end
    end
    false
  end

  def self.questions_count(current_user)
    counts = Question.where(user_id: current_user.id).count
    counts >= 3
  end

  def self.questions_save(question_forms, current_user)
    question_forms.each do |question_form|
      question = current_user.questions.create!(question_form[1])
      set_time = question.created_at + 12.hours
      DestroyQuestionsJob.set(wait_until: set_time).perform_later(question.id)
    end
  end
end


