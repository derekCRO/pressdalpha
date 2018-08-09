class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.string :page_heading
      t.text :page_description
      t.string :slug
      t.boolean :is_active

      t.timestamps
    end
  end
end
