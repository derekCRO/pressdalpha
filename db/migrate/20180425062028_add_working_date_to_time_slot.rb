class AddWorkingDateToTimeSlot < ActiveRecord::Migration[5.1]
  def change
    add_column :time_slots, :working_date, :datetime
  end
end
