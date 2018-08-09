class AddCategoryAttributeIdToCompanySelectedCategoryAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :company_selected_category_attributes, :category_attribute_id, :integer
  end
end
