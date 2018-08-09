class Addfieldstoblog < ActiveRecord::Migration[5.1]
  def change
    change_table :blogs do |t|
  		t.integer :blog_category_id
  		t.string :author
  		t.text :tags
  	end
  end
end
