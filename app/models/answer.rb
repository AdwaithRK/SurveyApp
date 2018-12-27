class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true
  belongs_to :survey
  belongs_to :survey_answer
end
