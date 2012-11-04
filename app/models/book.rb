class Book < ActiveRecord::Base
  attr_accessible :author, :title
  

  validates :author, presence: true
  validates :title, presence: true #uniqueness: { case_sensitive: true }
  validates_uniqueness_of :title, :scope => :author
  
end
