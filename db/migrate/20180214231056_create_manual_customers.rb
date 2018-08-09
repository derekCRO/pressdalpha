class CreateManualCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :manual_customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :phone
      t.string :address1
      t.string :address2
      t.string :city
      t.string :country
      t.string :zipcode
      t.float :latitude
      t.float :longitude
      t.references :company, index: true
      t.text :notes

      t.timestamps
    end
  end
end
