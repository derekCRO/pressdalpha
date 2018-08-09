class CreateVideo < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.boolean :video_type	
      t.string :url
      t.boolean :is_active
      t.timestamps
    end
  end
end
