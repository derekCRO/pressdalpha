class RenameCompanyTimeSlotToTimeSlot < ActiveRecord::Migration[5.1]
  def change
    rename_table :company_time_slots, :time_slots
  end
end
