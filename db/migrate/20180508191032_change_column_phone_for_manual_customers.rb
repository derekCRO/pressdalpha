class ChangeColumnPhoneForManualCustomers < ActiveRecord::Migration[5.1]
  def change
    change_column :manual_customers, :phone, :string
  end
end
