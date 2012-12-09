class Book < ActiveRecord::Base
  attr_accessible :author, :title
  has_many :posts, dependent: :destroy
  has_many :ratings, dependent: :destroy
  

  validates :author, presence: true
  validates :title, presence: true #uniqueness: { case_sensitive: true }
  validates_uniqueness_of :title, :scope => :author

  default_scope order: 'books.created_at DESC'
  
end
