class AddPartnerPreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :partnerpreferences do |t|
      t.references :company, index: true
      t.integer :company_id
      t.integer :order_limit, default: 100
      t.integer :postcode_limit, default: 100
      t.integer :user_limit, default: 2
      t.boolean :manual_bookings, default: false
      t.boolean :advanced_reports, default: false
      t.boolean :api_access, default: false
      t.boolean :rota_enabled, default: true
      t.boolean :auto_allocate, default: true
      t.timestamps
    end
  end
end
