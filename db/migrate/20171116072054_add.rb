class Add < ActiveRecord::Migration[5.1]
  def change
  	change_table :jobs do |t|
  		t.datetime :post_date
  	end
  end
end
