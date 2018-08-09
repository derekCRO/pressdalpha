class Addservicetypetocompanycategory < ActiveRecord::Migration[5.1]
  def change
  	change_table :company_selected_categories do |t|
  		t.string :service_type
  	end	
  end
end
