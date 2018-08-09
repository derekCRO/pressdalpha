class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :is_active
      t.boolean :is_admin
      t.date :date
      t.string :user_type
      t.integer :company_id
      t.text :about_me

      t.timestamps
    end
  end
end
