class AddNotificationSettingsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :notifications_email, :boolean, default: false
    add_column :users, :notifications_push, :boolean, default: false
    add_column :users, :notifications_marketing, :boolean, default: false
  end
end
