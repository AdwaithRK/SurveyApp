class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :answers, :survey_answer_id, :attempt_id
  end
end
