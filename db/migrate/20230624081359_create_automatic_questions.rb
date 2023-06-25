class CreateAutomaticQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :automatic_questions do |t|
      t.text "question", null: false
      t.text "answer", null: false
      t.timestamps
    end
    add_index :automatic_questions, :question, unique: true
  end
end
