class AddCategory < ActiveRecord::Migration[5.1]
	def change
	   create_table :categories, force: true do |t|
		  t.belongs_to :category
		  t.string :name, :null => false
		  t.boolean :is_active, default: true
		  t.timestamps
	   end
	end
end
