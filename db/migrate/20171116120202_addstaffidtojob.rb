class Addstaffidtojob < ActiveRecord::Migration[5.1]
  def change
  	change_table :jobs do |t|
  		t.integer :staff_id
  	end
  end
end
