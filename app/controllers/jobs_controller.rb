class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  def save
    @task = Task.find(params[:id])
    @id = params[:cid]
    @price = 30.00
    @admin_amount = @price * 0.1
    @company_amount = @price - @admin_amount

    @staff_ids = Staff.where(company_id: @task.company_id).ids

    staff_id = TimeSlot.where(user_slotable_id: @staff_ids, week_day_id: @task.booking_date.wday).uniq.sort[0].user_slotable_id if @task.company.partner.auto_assign_staff

    @job = Job.new(company_id: @task.company_id, user_id: @task.user_id, task_id: @task.id,  booking_date: @task.booking_date, booking_time: @task.booking_time, status: "#{staff_id.nil? ?  'Pending' : 'Confirmed'}", price: @price, post_date: Time.now, category_id: @task.category_id, latitude: @task.latitude, longitude: @task.longitude, address: @task.address, properties: @task.properties, zipcode: @task.zipcode, address1: @task.address1, address2: @task.address2, city: @task.city, country: @task.country, propertytext: @task.propertytext, staff_id: staff_id)
    # @job = Job.new(company_id: @task.company_id, user_id: @task.user_id, task_id: @task.id,  booking_date: @task.booking_date, booking_time: @task.booking_time, status: "booking_completed", price: @price, post_date: Time.now, category_id: @task.category_id, latitude: @task.latitude, longitude: @task.longitude, address: @task.address, properties: @task.properties, zipcode: @task.zipcode, address1: @task.address1, address2: @task.address2, city: @task.city, country: @task.country, propertytext: @task.propertytext, staff_id: staff_id)
    respond_to do |format|
      if @job.save
        if @job.status == "booking_completed"
           ChargeBookingJob.set(wait: 24.hours).perform_later(@job.id)
        end
        @string = "JOB0000"
        @jobId = @string + @job.id.to_s
        @string2 = "TRN0000"
        @trnId = @string2 + @job.id.to_s
        # @job.update(:id=>@job.id, :view_job_id=>@jobId)
        @job.update(:view_job_id=>@jobId)
        puts "#{{:company_id => @task.company_id, :customer_id => @task.user_id, :partner_id => @task.company.user_id, :job_id => @job.id,  :date => Time.now, :total_amount => @price, :company_amount => @company_amount, :admin_amount => @admin_amount, :status => 'Paid', :transaction_id => @trnId}}"

        @transaction = Transaction.new(:company_id => @task.company_id, :customer_id => @task.user_id, :partner_id => @task.company.user_id, :job_id => @job.id,  :date => Time.now, :total_amount => @price, :company_amount => @company_amount, :admin_amount => @admin_amount, :status => 'Paid', :transaction_id => @trnId)
        @transaction.save
        format.html { redirect_to users_list_path}
        format.json  { render :json => @job, status => "success" }
      else
        format.json  { render :json => @job, status => "error" }
      end
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:user_id, :task_id, :company_id, :booking_date, :booking_time, :price, :status, :view_job_id, :post_date, :category_id, :latitude, :longitude, :zipcode, :address,  :address1, :address2, :city, :country, :properties=>{}, :propertytext=>{})
    end
end
