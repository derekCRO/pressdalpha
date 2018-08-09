class AddInfoTocategoryAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :category_attributes, :information, :string
  end
end
