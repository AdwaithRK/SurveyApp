class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :question_options, :through => :questions
  accepts_nested_attributes_for :questions, :allow_destroy => true
  accepts_nested_attributes_for :question_options, :allow_destroy => true

  validates :token, presence: true
  validates :token, uniqueness: true
  before_validation :generate_token, on: :create

  def generate_token
    begin
      self.token = SecureRandom.urlsafe_base64(64, false)
    end while self.class.find_by(token: token)
  end

  def to_param
    token
  end

end
