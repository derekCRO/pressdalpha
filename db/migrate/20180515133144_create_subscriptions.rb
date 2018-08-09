class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :recurring_type
      t.integer :recurring_weeks_in_month
      t.integer :recurring_months
      t.integer :first_job_id
      t.date :date_of_first_booking
      t.decimal :recurring_price, :precision => 8, :scale => 2
      t.integer :user_id
      t.integer :partner_id
      t.integer  :company_id
      t.integer :category_id
      t.timestamps null: false
    end
  end
end
