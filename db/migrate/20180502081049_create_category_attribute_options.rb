class CreateCategoryAttributeOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :category_attribute_options do |t|
      t.integer  :category_attribute_id
      t.string   :options
      t.integer  :option_hours
      t.integer  :option_price

      t.timestamps
    end
  end
end
