class AddSurveyAnswerToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :answers, :survey_answer, foreign_key: true
  end
end
