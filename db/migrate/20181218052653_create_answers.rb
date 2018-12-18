class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :answer
      t.boolean :is_optional_answer
      t.belongs_to :question, foreign_key: true
      t.belongs_to :answer, foreign_key: true
      t.belongs_to :survey, foreign_key: true

      t.timestamps
    end
  end
end
