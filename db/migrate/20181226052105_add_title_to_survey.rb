class AddTitleToSurvey < ActiveRecord::Migration[5.2]
  def change
    rename_column :surveys, :name, :title
    add_column :surveys, :description, :text
    rename_column :questions, :is_optional_question, :has_options
  end
end
