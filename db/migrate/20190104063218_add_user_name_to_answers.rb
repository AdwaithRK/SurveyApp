class AddUserNameToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :user_name, :text
  end
end
