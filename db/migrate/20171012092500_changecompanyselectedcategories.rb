class Changecompanyselectedcategories < ActiveRecord::Migration[5.1]
  def change
  	change_table :company_selected_categories do |t|
       t.integer :parent_id
       t.integer :category_id
       t.string :price_per_hour
     end	
  end
end
