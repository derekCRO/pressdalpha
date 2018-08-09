class Addaddressandotherintask < ActiveRecord::Migration[5.1]
  def change
    change_table :tasks do |t|
  		t.string :address1
  		t.string :address2
  		t.string :city
  		t.string :country
  	end
  end
end
