class ChangeColumnRatingsScore < ActiveRecord::Migration
  def change
    change_column_null :ratings, :score, null: false  
  end
end
