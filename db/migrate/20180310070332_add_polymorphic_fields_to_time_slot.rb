class AddPolymorphicFieldsToTimeSlot < ActiveRecord::Migration[5.1]
  def change
    add_reference :time_slots, :user_slotable, polymorphic: true
  end
end
