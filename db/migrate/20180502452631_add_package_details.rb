class AddPackageDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :packagedetails do |t|
      t.string :package_name, null: false
      t.integer :order_limit, default: 100
      t.integer :postcode_limit, default: 100
      t.integer :user_limit, default: 2
      t.boolean :manual_bookings, default: false
      t.boolean :advanced_reports, default: false
      t.boolean :api_access, default: false
      t.integer :monthly_cost, default: 0
      t.timestamps
    end
  end
end
