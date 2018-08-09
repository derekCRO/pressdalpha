class CreateBlogCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :blog_categories do |t|
      t.string :name
      t.boolean :is_active

      t.timestamps
    end
  end
end
