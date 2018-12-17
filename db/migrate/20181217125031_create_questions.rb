class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :question
      t.boolean :optional, :default => false
      t.belongs_to :survey, foreign_key: true

      t.timestamps
    end
  end
end
