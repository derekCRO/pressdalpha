class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :company_id
      t.date :booking_date
      t.string :booking_time
      t.decimal :price
      t.string :status

      t.timestamps
    end
  end
end
