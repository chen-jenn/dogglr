class User < ApplicationRecord
  has_many :comments, dependent: :nullify #even if user is deleted, the comments or posts remain
  has_many :posts, dependent: :nullify
  has_secure_password
  validates :first_name, :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,
    presence: true,
    uniqueness: true,
    format: VALID_EMAIL_REGEX

  #might be useful later since we don't have username option yet 
  def full_name
    "#{first_name} #{last_name}"
  end
end
