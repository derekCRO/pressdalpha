class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :is_active
      t.string :company_name
      t.text :about_company
      t.string :location
      t.string :logo
      t.string :service

      t.timestamps
    end
  end
end
