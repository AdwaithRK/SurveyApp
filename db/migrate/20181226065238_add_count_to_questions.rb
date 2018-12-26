class AddCountToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :question_count, :integer
    add_column :questions, :option_count, :integer
  end
end
