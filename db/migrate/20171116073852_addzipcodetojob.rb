class Addzipcodetojob < ActiveRecord::Migration[5.1]
  def change
  	change_table :jobs do |t|
  		t.string :zipcode
  	end
  end
end
