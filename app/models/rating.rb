class Rating < ActiveRecord::Base
  attr_accessible :book_id, :score  

  belongs_to :user, foreign_key: "user_id"
  belongs_to :book, foreign_key: "book_id"  

  validates :user_id, presence: true 
  validates :book_id, presence: true 
  validates :score, presence: true

  validates_numericality_of :score, only_integer: true, message: "Only whole numbers accepted"
  validates_inclusion_of :score, :in => 0..100, message: "Must be in range 0..100"
   
end
