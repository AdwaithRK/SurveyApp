class AddIsadminToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :isadmin, :boolean, :default => false
  end
end
