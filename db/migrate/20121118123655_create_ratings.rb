class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :score
      t.integer :book_id
      t.integer :user_id

      t.timestamps
    end
    add_index :ratings, :book_id
    add_index :ratings, :user_id
    add_index :ratings, [:user_id, :book_id], unique: true
  end
end
