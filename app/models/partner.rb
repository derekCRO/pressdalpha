class Partner < User
  has_one :company, class_name: "Company", foreign_key: "user_id"

  def events(options={})
    company = self.company
    time_slots = company.time_slots
    time_slots = time_slots || []
    Date.beginning_of_week = :sunday
    today = Date.today()
    @events = []
    (today.at_beginning_of_week..today.at_end_of_week).map.each do |date|
      today_date = date.strftime("%A")
      time_slots = company.time_slots.includes(:week_day).where(week_days: {day_name: today_date})
      time_slots.each do |t|
        hash = {}
        hash['title'] = t.id
        hash['start'] = "#{date} #{t.starting_time.strftime("%H:%M")}"
        hash['end'] = "#{date} #{t.ending_time.strftime("%H:%M")}"
        hash['staff_count'] = (company.staffs.map{|s| s.time_slots.where("starting_time <= ? AND ending_time >= ?", hash['start'], hash['end'])}.count - Job.where("staff_id  IN (?) AND booking_date = ?", company.staffs.ids, Date.parse(date.to_s)).count) if options[:staff_count].present?
        @events << hash if !hash.empty?
      end
    end
    @events
  end

  def save_hours(week_day, start_time, end_time)
    week_day = WeekDay.find_by(day_name: week_day)
    company = self.company
    time_slots = company.time_slots
    time_slot = time_slots.new(week_day: week_day, added_by: self, starting_time: start_time, ending_time: end_time, user_slotable: company)
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
  end
end
