class AddExtraImagesToCategory < ActiveRecord::Migration[5.1]
change_table :categories do |t|
    t.attachment :mobile_cover_image
    t.attachment :mobile_icon
  end
end
