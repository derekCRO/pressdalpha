class UpdateDefautlValueforCategories < ActiveRecord::Migration[5.1]
  def up
    change_column :categories, :is_active, :boolean, default: false
  end

  def down
    change_column :categories, :is_active, :boolean, default: true
  end
end
