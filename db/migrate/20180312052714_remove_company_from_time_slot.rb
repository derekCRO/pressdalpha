class RemoveCompanyFromTimeSlot < ActiveRecord::Migration[5.1]
  def change
    remove_reference :time_slots, :company, foreign_key: true
  end
end
