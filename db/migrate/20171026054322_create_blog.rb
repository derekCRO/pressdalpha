class CreateBlog < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.attachment :image
      t.boolean :is_active
      t.timestamps
    end
  end
end
