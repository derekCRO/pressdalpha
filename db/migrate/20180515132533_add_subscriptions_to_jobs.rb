class AddSubscriptionsToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :recurring_weeks, :integer
    add_column :jobs, :subscription_id, :integer
  end
end
