class Addlatlongtask < ActiveRecord::Migration[5.1]
  def change
  	change_table :tasks do |t|
  		t.float :latitude
          t.float :longitude
          t.string :address
  	end
  end
end
