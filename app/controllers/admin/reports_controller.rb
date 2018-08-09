class Admin::ReportsController < Admin::BaseAdminController

  def index
    @transactions= Transaction.all
  end

  def show
    render template: "reports/#{params[:page]}"
  end

  def overall_revenue_json
    render json: Transaction.group_by_day(:date).sum(:company_amount)
  end

  def overall_bookings_json
    render json: Job.group_by_day(:created_at).count
  end

  def overall_bookings_last_week_json
    render json: Job.group_by_day(:created_at, last: 7).count
  end

  def recurring_vs_new_customers_bookings_json
      @total_jobs = Job.count
      distinct_jobs = Job.pluck('distinct user_id').count
      recurring_jobs = Job.select(:user_id).having("count(*) > 1").count
      respond_to do |format|
        format.json  { render :json => {:Bookings_From_New_Customers => distinct_jobs,
                                        :Bookings_From_Returning_Customers => recurring_jobs }}
      end
  end

  def recurring_vs_new_customers_bookings_last_week_json
      @total_jobs = Job.count
      distinct_jobs = Job.where('created_at >= ?', 1.week.ago).pluck('distinct user_id').count
      recurring_jobs = Job.where('created_at >= ?', 1.week.ago).select(:user_id).having("count(*) > 1").count
      respond_to do |format|
        format.json  { render :json => {:Bookings_From_New_Customers => distinct_jobs,
                                        :Bookings_From_Returning_Customers => recurring_jobs }}
      end
  end

  def customer_retention_json
      @total_jobs = Job.all.count
      distinct_jobs = Job.pluck('distinct user_id').count
      recurring_jobs = Job.select(:user_id).having("count(*) > 1").count
      percentage = ( recurring_jobs.to_f / @total_jobs.to_f   )
      render :json => percentage
  end

  def transaction_revenue_last_week_json
      @transactions = Transaction.where('date >= ?', 1.week.ago).sum(:total_amount)
      render :json => @transactions
  end

  end
