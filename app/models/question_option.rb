class QuestionOption < ApplicationRecord
  belongs_to :question
  belongs_to :answer, optional: true
end
