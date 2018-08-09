class Adduseridtocompany < ActiveRecord::Migration[5.1]
  def change
  	change_table :companies do |t|
       t.integer :category_id
     end
  end
end
