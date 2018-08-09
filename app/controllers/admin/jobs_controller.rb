class Admin::JobsController < Admin::BaseAdminController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  def save
    @task = Task.find(params[:id])
    @id = params[:cid]
    @job = Job.new(:company_id => @task.company_id, :user_id => @task.user_id, :task_id => @task.id,  :booking_date => @task.booking_date, :booking_time => @task.booking_time, :status => 'Pending', :price => '30.00', :post_date => Time.now, :category_id => @task.category_id, :latitude => @task.latitude, :longitude => @task.longitude, :address => @task.address, :properties => @task.properties, :zipcode => @task.zipcode)
    respond_to do |format|
      if @job.save
        @string = "JOB0000"
        @jobId = @string + @job.id.to_s
        @job.update(:id=>@job.id, :view_job_id=>@jobId)
        format.html { redirect_to users_list_path}
        format.json  { render :json => @job, status => "success" }
      else
        format.json  { render :json => @job, status => "error" }
      end
    end
  end

  def list
    @tasks = Job.all
    @taskspending = Job.where(status: 'booking_made').order("id DESC")
    @tasksassigned = Job.where(status: ['booking_confirmed', 'staff_enroute', 'booking_inprogress', 'dispute' ]).order("id DESC")
    @taskscompleted = Job.where(status: 'booking_complete').order("id DESC")
  end

  def list_manual
     @taskspending = Job.where(status: 'booking_made').where(is_manual_booking: 'true').order("id DESC")
     @tasksassigned = Job.where(status: ['booking_confirmed', 'staff_enroute', 'booking_inprogress', 'dispute' ]).where(is_manual_booking: 'true').order("id DESC")
     @taskscompleted = Job.where(status: 'booking_complete').where(is_manual_booking: 'true').order("id DESC")
  end


  # GET /customers/task_details
  def details
     @task = Job.find(params[:id])
     @id = params[:cid]
     #@category = Category.find(@task.category_id)#
     @subcategories = Category.where(category_id: @task.category_id)
     @text = @task.propertytext
     respond_to do |format|
       format.html
       format.js
     end
  end

  def add_staff
      @tasks = Job.find(params[:id])
      @users = User.where(user_type: 'Staff').order("id DESC")
      respond_to do |format|
        format.html
        format.js
      end
  end

  def jobs_update
  @jobs = Job.find(params[:id])
  respond_to do |format|
    if @jobs.update(job_params)
      format.html { redirect_to admin_jobs_add_staff_path, notice: 'Job was successfully updated.' }
      format.json { render :show, status: :ok, location: @job }
    else
      format.html { render :edit }
      format.json { render json: @job.errors, status: :unprocessable_entity }
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
    @task = Task.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @task = Task.new(task_params)
    respond_to do |format|
      if @job.save
        format.html { redirect_to admin_jobs_list_manual_path, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
        format.js { redirect_to admin_jobs_list_manual_path, notice: 'Job was successfully created.' }
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
      params.require(:job).permit(:user_id, :task_id, :company_id, :booking_date, :booking_time, :price, :is_manual_booking, :status, :view_job_id, :post_date, :category_id, :address1, :city, :country, :latitude, :longitude, :address, :properties, :zipcode, :staff_id)
    end

    def task_params
      params.require(:task).permit(:user_id, :category_id, :zipcode, :is_active, :is_manual_booking, :booking_date, :booking_time, :latitude, :longitude, :address, :company_id, :task_type, :address1, :address2, :city, :country, :freq, :properties=>{}, :propertytext=>{})
    end
end
