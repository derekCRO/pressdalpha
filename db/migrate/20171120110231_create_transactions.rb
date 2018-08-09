class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :customer_id
      t.integer :partner_id
      t.integer :company_id
      t.integer :job_id
      t.datetime :date
      t.decimal :total_amount
      t.decimal :company_amount
      t.decimal :admin_amount
      t.string :status
      t.string :transaction_id

      t.timestamps
    end
  end
end
