class AddTokenToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :link, :string
    add_index :surveys, :link, unique: true
  end
end
