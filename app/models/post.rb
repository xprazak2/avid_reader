class Post < ActiveRecord::Base
  attr_accessible  :content, :book_id
  
  belongs_to :user, foreign_key: "user_id"
  belongs_to :book, foreign_key: "book_id"

  validates :book_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true

  default_scope order: 'posts.created_at DESC'
  
end
