class Api::V1::CheckTimeSlotFreeController < Api::V1::ApplicationController
  skip_before_action :authenticate_user!, raise: false
  respond_to :json

	def get_days
    @companies_with_green, @companies_with_orange = Company.get_companies_data(params[:zipcode][0...4],params[:properties], params[:total_hours])
    eventDates = {}
    hash_test = {}
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    green_dates = []
    orange_dates = []
    @green_time_slots = TimeSlot.where(user_slotable: @companies_with_green).pluck(:week_day_id).uniq.map{|d| d = d - 1 }
    @orange_time_slots = TimeSlot.where(user_slotable: @companies_with_orange).pluck(:week_day_id).uniq.map{|d| d = d - 1 }

    (start_date..end_date).each do |date|
      puts date.wday
      if @green_time_slots.include?(date.wday)
        green_dates << date
      elsif @orange_time_slots.include?(date.wday)
        orange_dates << date
      end
    end
    render json: {
              status: 200,
              message: 'Below is a list of all dates requested',
              green_dates: green_dates,
              orange_dates: orange_dates
            }.to_json, status: 200
  end

  def get_time_slots
    s = Job.where(company_id: params[:company_id], booking_date: params[:date]).where('booking_time LIKE ?', "%#{params[:time]}%")

    render json: {
              status: 200,
              message: 'Below is a list of all time slots requested',
              is_available_time_slots: !s.present?
            }.to_json, status: 200
  end

  # private
  #   def comment_params
	# 		params.require(:comment).permit(:user_id, :content )
  #   end

end
