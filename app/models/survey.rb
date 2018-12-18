class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions

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
