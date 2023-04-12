class SendQuestionJob < ApplicationJob
  queue_as :default

  def perform(*args)
    question = current_user.questions
  end
end
