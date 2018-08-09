class TimeSlot < ApplicationRecord


  belongs_to :week_day
  belongs_to :added_by, foreign_key: "added_by_id", class_name: "Partner", optional: true
  belongs_to :user_slotable, polymorphic: true

  private


end
