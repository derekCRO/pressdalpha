class AddMessageToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :message, :string
    add_column :notifications, :stuck, :boolean, default: false
  end
end
