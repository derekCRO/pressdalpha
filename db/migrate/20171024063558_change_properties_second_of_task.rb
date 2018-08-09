class ChangePropertiesSecondOfTask < ActiveRecord::Migration[5.1]
  def change
  	change_column :tasks, :properties, :text
  end
end
