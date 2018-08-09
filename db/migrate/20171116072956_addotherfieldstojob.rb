class Addotherfieldstojob < ActiveRecord::Migration[5.1]
  def change
  	change_table :jobs do |t|
  		t.integer :category_id
  		t.string :latitude
  		t.string :longitude
  		t.string :address
  		t.text :properties
  	end
  end
end
