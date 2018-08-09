class CraeteCompaniesSelectedCategoryAttribute < ActiveRecord::Migration[5.1]
  def change
  	create_table :company_selected_category_attributes do |t|
  	  t.integer :company_id	
      t.string :name
      t.string :field_type
      t.float :hour_per_item
      t.float :material_cost
      t.boolean :required
      t.belongs_to :category, foreign_key: true
      t.timestamps
    end  
  end
end
