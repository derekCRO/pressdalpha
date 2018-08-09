class Addpriceperhourtocategory < ActiveRecord::Migration[5.1]
  def change
     change_table :categories do |t|
       t.float :price_per_hour, default: 0.00
     end  
  end
end
