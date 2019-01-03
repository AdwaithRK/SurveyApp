class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :question_options, :through => :questions
  has_many :attempts
  accepts_nested_attributes_for :questions, :allow_destroy => true
  accepts_nested_attributes_for :question_options, :allow_destroy => true

  validates :link, presence: true
  validates :link, uniqueness: true
  before_validation :generate_token, on: :create

  def generate_token
    begin
      self.link = SecureRandom.urlsafe_base64(64, false)
    end while self.class.find_by(link: link)
  end

  def to_param
    link
  end

  def title=(title)
    if title == ''
      write_attribute(:title, 'Untitled form')
    else
      write_attribute(:title, title)
    end
  end

  def self.format_question(question_array, survey_id, attempt_id,current_user)
    answers = Array.new()
    user_id = current_user.id if current_user
    question_array.each do |key, value|
      answers.push({question_id: value[:question_id], survey_id: survey_id, attempt_id: attempt_id, answer: value[:answer_text], user_id: user_id})
    end
    answers
  end

end
