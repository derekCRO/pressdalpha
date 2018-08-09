class AddManualcustomersToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :is_manual_booking, :boolean, default: false
    add_reference :jobs, :manual_customers, index: true
  end
end
