class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers
  has_many :question_options, dependent: :destroy
  enum question_type: ["text", "radio", "drop_down", "checkbox", "multiselect_drop_down"]
  accepts_nested_attributes_for :question_options, :allow_destroy => true
  validates :question, presence: true
end
