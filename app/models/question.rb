class Question < ApplicationRecord
  after_save :delete_children_if_text
  validates :question, presence: true

  belongs_to :survey
  has_many :answers
  has_many :question_options, dependent: :destroy
          # -> { joins(:question).where({ questions: { question_type: 'text' } }) }
          #  ->(obj) { where(obj.question_type != 'text') }

  accepts_nested_attributes_for :question_options, allow_destroy: true

  enum question_type: %w[
    text radio drop_down checkbox
    multiselect_drop_down
  ]

  def delete_children_if_text
    if self.question_type == 'text'
      self.question_options.destroy_all
    end
  end

end
