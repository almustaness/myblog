class Author < ActiveRecord::Base
  has_many :articles
  has_many :thumbs
  has_many :comments
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum:2}
  validates :authName, presence: true, length: {minimum: 3}
  has_secure_password
end