class Adduseridnewtocompany < ActiveRecord::Migration[5.1]
  def change
    change_table :companies do |t|
       t.integer :user_id
     end
  end
end
