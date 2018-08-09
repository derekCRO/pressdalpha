class Addpriceandparentidincompanycategoryattribute < ActiveRecord::Migration[5.1]
  def change
     change_table :company_selected_category_attributes do |t|
  		t.integer :company_selected_category_parent_id
  		t.string :price_per_hour
  	end
  end
end
