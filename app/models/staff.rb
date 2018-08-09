class Staff < User

  belongs_to :company
  has_many   :time_slots, as: :user_slotable

  def events
    my_time_slots = self.time_slots
    Date.beginning_of_week = :sunday
    today = Date.today()
    @events = []
    (today.at_beginning_of_week..today.at_end_of_week).map.each do |date|
      today_date = date.strftime("%A")
      my_time_slots = time_slots.includes(:week_day).where(week_days: {day_name: today_date})
      my_time_slots.each do |t|
        hash = {}
        hash['title'] = t.id
        if t.working_date?
          hash['start'] = "#{t.working_date.strftime("%Y-%m-%d")} #{t.starting_time.strftime("%H:%M")}"
          hash['end'] = "#{t.working_date.strftime("%Y-%m-%d")} #{t.ending_time.strftime("%H:%M")}"
        end
        @events << hash if !hash.empty?
      end
    end
    @events
  end

  def save_staff_hours(week_day, start_time, end_time, working_date)
    company = self.company
    time_slots = self.time_slots
    time_slot = time_slots.new(week_day: week_day, starting_time: start_time, ending_time: end_time, user_slotable: self, working_date: working_date)
    todays_existing_time_slots = time_slots.where(week_day: week_day)

    if todays_existing_time_slots.count > 0

      # Condition to check if the new time slot encloses entire existing slot
      between_time_slots = todays_existing_time_slots.where('starting_time >= ? AND ending_time <= ?', time_slot.starting_time, time_slot.ending_time)
      between_time_slots.destroy_all if between_time_slots.present?

      # Condition to check if the existing slot's starting_time is between new time slot
      starting_time_slots = todays_existing_time_slots.where('starting_time BETWEEN ? AND ?', time_slot.starting_time, time_slot.ending_time)
      starting_time_slots.update(starting_time: time_slot.ending_time) if starting_time_slots.present?

      # Condition to check if the existing slot's ending_time is between new time slot
      ending_time_slots = todays_existing_time_slots.where('ending_time BETWEEN ? AND ?', time_slot.starting_time, time_slot.ending_time)
      ending_time_slots.update(ending_time: time_slot.starting_time) if ending_time_slots.present?

    end

    # Time Slots when created within existing time slots
    outside_time_slots = todays_existing_time_slots.where('starting_time <= ? AND ending_time >= ?', time_slot.starting_time, time_slot.ending_time)

    time_slot.save! unless outside_time_slots.present?
    time_slot
  end

end
