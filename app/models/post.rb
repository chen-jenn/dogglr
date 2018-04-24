class Post < ApplicationRecord
  belongs_to :user 
  has_many :comments, dependent: :destroy
  validates :title, presence: true, uniqueness: { message: 'Title must be unique' }
  validates :body, presence: true, length: { minimum: 50 }
end
