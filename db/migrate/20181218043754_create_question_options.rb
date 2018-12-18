class CreateQuestionOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :question_options do |t|
      t.text :option
      t.belongs_to :question, foreign_key: true

      t.timestamps
    end
  end
end
