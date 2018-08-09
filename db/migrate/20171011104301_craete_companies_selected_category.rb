class CraeteCompaniesSelectedCategory < ActiveRecord::Migration[5.1]
  def change
  	    create_table :company_selected_categories, force: true do |t|
		  t.integer :category
		  t.integer :company_id
		  t.string :name, :null => false
		  t.boolean :is_active, default: true
		  t.timestamps
	    end
  end
end
