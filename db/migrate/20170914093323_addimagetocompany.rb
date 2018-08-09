class Addimagetocompany < ActiveRecord::Migration[5.1]
  def change
  	 change_table :companies do |t|
      t.attachment :image
     end
  end
end
