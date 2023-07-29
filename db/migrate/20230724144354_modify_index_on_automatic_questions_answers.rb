class ModifyIndexOnAutomaticQuestionsAnswers < ActiveRecord::Migration[7.0]
  def change
    remove_index :automatic_questions, name: "index_automatic_questions_on_question"
    add_index :automatic_questions, :answer, unique: true
  end
end
