class DeleteQuestionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    question = Question.find(args[0])
    question.destroy!
  end
end
