class AddManualcustomersToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :is_manual_booking, :boolean, default: false
    add_reference :tasks, :manual_customers, index: true
  end
end
