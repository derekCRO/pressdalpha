class AddIsActiveToConversation < ActiveRecord::Migration[5.1]
  def change
    add_column :conversations, :is_active, :boolean
  end
end
