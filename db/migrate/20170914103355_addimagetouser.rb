class Addimagetouser < ActiveRecord::Migration[5.1]
  def change
  	change_table :users do |t|
      t.attachment :image
    end
  end
end
