class Article < ActiveRecord::Base
  belongs_to :category
  belongs_to :author
  has_many :thumbs
  has_many :comments
  
 validates :artTitle, presence: true, length: {minimum: 9, maximum: 20}
 validates :artBody, presence: true, length: {minimum: 20, maximum: 100}
 
 #accepts_nested_attributes_for :comments

  
end