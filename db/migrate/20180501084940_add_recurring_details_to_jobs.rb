class AddRecurringDetailsToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :recurring, :boolean
    add_column :jobs, :recurring_type, :string
  end
end
