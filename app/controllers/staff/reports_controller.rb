class Staff::ReportsController < Staff::BaseStaffController

  def index
    @transactions= Transaction.all
  end

  def show
    render template: "reports/#{params[:page]}"
  end

  def bookings_complete_last_week_json
    render json: Job.where('booking_date >= ?', 1.week.ago).where(status: ['booking_complete']).where("staff_id = ?", current_staff.id)
  end

end
