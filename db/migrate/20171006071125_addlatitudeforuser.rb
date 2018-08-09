class Addlatitudeforuser < ActiveRecord::Migration[5.1]
  def change
  	change_table :users do |t|
       t.float :latitude
       t.float :longitude
     end	
  end
end
