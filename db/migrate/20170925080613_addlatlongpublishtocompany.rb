class Addlatlongpublishtocompany < ActiveRecord::Migration[5.1]
  def change
  	change_table :companies do |t|
       t.float :latitude
       t.float :longitude
       t.string :zipcode
       t.boolean :is_publish, default: false
     end	
  end
end
