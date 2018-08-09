class Addbookingtimetotask < ActiveRecord::Migration[5.1]
  def change
  	change_table :tasks do |t|
  		t.string :booking_time
  	end
  end
end
