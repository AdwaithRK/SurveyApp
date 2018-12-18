class AddIsOptionalToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :is_optional_question, :boolean, :default => true 
  end
end
