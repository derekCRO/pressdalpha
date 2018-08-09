class AddPartnerIdToManualCustomers < ActiveRecord::Migration[5.1]
  def change
    change_table :manual_customers do |t|
      t.references :partner, index: true
    end
  end
end
