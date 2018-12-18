class Question < ApplicationRecord
  belongs_to :survey
  has_many :question_options, -> { where is_optional_question: true }
  enum type: ["text", "radio_button", "drop_down", "checkbox", "multiselect_drop_down"]
end
