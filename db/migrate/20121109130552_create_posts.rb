class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
    add_index :posts, :created_at
  end
end
