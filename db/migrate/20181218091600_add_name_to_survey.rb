class AddNameToSurvey < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :name, :text
  end
end
