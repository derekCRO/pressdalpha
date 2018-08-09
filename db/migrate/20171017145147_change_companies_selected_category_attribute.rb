class ChangeCompaniesSelectedCategoryAttribute < ActiveRecord::Migration[5.1]
  def change
  	change_table :company_selected_category_attributes do |t|
       t.integer :company_selected_category_id
       t.boolean :is_company_support, default: true
       
     end	
  end
end
