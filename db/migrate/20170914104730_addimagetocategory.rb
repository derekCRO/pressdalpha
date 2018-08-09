class Addimagetocategory < ActiveRecord::Migration[5.1]
  change_table :categories do |t|
      t.attachment :image
    end
end
