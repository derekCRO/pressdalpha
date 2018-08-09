class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :zipcode
      t.boolean :is_active
      t.date :booking_date

      t.timestamps
    end
  end
end
