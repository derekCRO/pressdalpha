class Addotherfieldstoaccountuser < ActiveRecord::Migration[5.1]
  def change
  	change_table :users do |t|
  		t.string :address1
  		t.string :address2
  		t.string :city
  		t.string :country
  		t.string :zipcode
 	end
  end
end
