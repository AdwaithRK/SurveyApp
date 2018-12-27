class AddSurveyidToSurveyAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :survey_answers, :survey_id, :integer
  end
end
