class Addaddressandotherinjob < ActiveRecord::Migration[5.1]
  def change
    change_table :jobs do |t|
  		t.string :address1
  		t.string :address2
  		t.string :city
  		t.string :country
  		t.text :propertytext
  	end
  end
end
