class AddAutoAssignStaffToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :auto_assign_staff, :boolean, default: false
  end
end
