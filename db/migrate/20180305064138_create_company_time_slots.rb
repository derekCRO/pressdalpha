class CreateCompanyTimeSlots < ActiveRecord::Migration[5.1]
  def change
    create_table :company_time_slots do |t|
      t.references :company, foreign_key: true
      t.references :week_day, foreign_key: true
      t.references :added_by
      t.time :starting_time
      t.time :ending_time

      t.timestamps
    end
  end
end
