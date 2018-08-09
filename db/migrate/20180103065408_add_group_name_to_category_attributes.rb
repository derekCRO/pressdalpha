class AddGroupNameToCategoryAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :category_attributes, :group_name, :string
  end
end
