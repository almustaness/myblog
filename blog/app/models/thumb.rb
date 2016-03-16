class Thumb < ActiveRecord::Base
  belongs_to :article
  belongs_to :author
  
  validates_uniqueness_of :author, scope: :article
end