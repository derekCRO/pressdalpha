class Change < ActiveRecord::Migration[5.1]
def change
  change_column :companies, :selected_package, 'integer USING CAST(selected_package AS integer)'
end
end
