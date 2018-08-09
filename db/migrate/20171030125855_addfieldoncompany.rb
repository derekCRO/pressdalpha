class Addfieldoncompany < ActiveRecord::Migration[5.1]
  def change
  	change_table :companies do |t|
  		t.integer :servicearea_radius
        t.string :servicestart_time
        t.string :serviceend_time
        t.string :service_type
  	end
  end
end
