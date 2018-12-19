class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers
  has_many :question_options, -> { where is_optional_question: true }, dependent: :destroy
  enum type: ["text", "radio_button", "drop_down", "checkbox", "multiselect_drop_down"]
  accepts_nested_attributes_for :question_options, :allow_destroy => true
end
