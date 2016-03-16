class Category < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  validates :catName, presence: true, length: {minimum: 3, maximum: 20}
end