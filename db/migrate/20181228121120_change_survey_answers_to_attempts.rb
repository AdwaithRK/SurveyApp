class ChangeSurveyAnswersToAttempts < ActiveRecord::Migration[5.2]
  def change
    rename_table :survey_answers, :attempts
  end
end
