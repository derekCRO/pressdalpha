class Partner::JobsController < Partner::BasePartnerController
  before_action :set_job, only: [:show, :edit, :update, :destroy, :add_staff]
  before_action :set_company, only: [:new, :list, :list_manual, :add_staff, :jobs_update]

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
    @taskspending = Job.pending_jobs(@company.id).reverse_order
    @tasksassigned = Job.assigned_jobs(@company.id).reverse_order
    @taskscompleted = Job.completed_jobs(@company.id).reverse_order
  end

  def list_manual
     @taskspending = Job.pending_jobs(@company.id).reverse_order
     @tasksassigned = Job.assigned_jobs(@company.id).reverse_order
     @taskscompleted = Job.completed_jobs(@company.id).reverse_order
  end

  # GET /customers/task_details
  def details
     @task = Job.find(params[:id])
     @id = params[:cid]
     @category = Category.find(@task.category_id)
     @subcategories = Category.where(category_id: @task.category_id)
     @text = @task.propertytext
     respond_to do |format|
       format.html
       format.js
     end
  end

  def manualdetails
     @task = Job.find(params[:id])
     @id = params[:cid]
     @category = Category.find(@task.category_id)
     @subcategories = Category.where(category_id: @task.category_id)
     @manual_customer = ManualCustomer.find(@task.manual_customers_id)
     @text = @task.propertytext
     respond_to do |format|
       format.html
       format.js
     end
  end

  def add_staff
       @jobs = Job.find(params[:id])
       @users = @company.staffs.reverse_order
       @users = @users.map{|s| s if (s.time_slots.where(working_date: @jobs.booking_date).present? && Job.where(booking_date: @jobs.booking_date).where.not(staff_id: s.id).or(Job.where(booking_date: @jobs.booking_date).where(staff_id: nil)).present?)}.compact
       respond_to do |format|
         format.html
         format.js
       end
   end

  def jobs_update
  	@jobs = Job.find(params[:id])
    @jobs.update(job_params)
    respond_to do |format|
      if @jobs.update(job_params)
        format.html { redirect_to partner_jobs_list_path
          flash[:success] = 'Job was successfully updated'
        }
        format.js
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def staff_enroute
  @job = Job.find(params[:id])
  @job.update_attributes(:status => "staff_enroute")
  respond_to do |format|
    if @job.update(job_params)
      format.html { redirect_to partner_jobs_list_path
        flash[:success] = 'Job updated to En-Route'
      }
    format.js
    format.json { render :show, status: :ok, location: @job }
    end
  end
  end

  def booking_inprogress
  @job = Job.find(params[:id])
  @job.update_attributes(:status => "booking_inprogress")
    respond_to do |format|
      if @job.update(job_params)
      format.html { redirect_to partner_jobs_list_path
        flash[:success] = 'Job updated to In Progress'
      }
    format.js
    format.json { render :show, status: :ok, location: @job }
    end
  end
  end

  def booking_complete
  @job = Job.find(params[:id])
  @job.update_attributes(:status => "booking_complete")
    respond_to do |format|
      if @job.update(job_params)
      format.html { redirect_to partner_jobs_list_path
        flash[:success] = 'Job completed.'
      }
    format.js
    format.json { render :show, status: :ok, location: @job }
    end
  end
  end

  def booking_rejected
  @job = Job.find(params[:id])
  @job.update_attributes(:status => "booking_rejected")
  respond_to do |format|
  if @job.update(job_params)
      format.html { redirect_to partner_jobs_list_path
        flash[:warning] = 'Job Rejected.'
      }
    format.js
    format.json { render :show, status: :ok, location: @job }
    end
  end
  end


  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @manual_customers = ManualCustomer.all
    @job = Job.new
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
    respond_to do |format|
      if @job.save
        format.html { redirect_to partner_jobs_list_manual_path, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
        format.js { redirect_to partner_jobs_list_manual_path, notice: 'Job was successfully created.' }
      else
        format.html { redirect_to partner_jobs_list_manual_path, notice: 'Job failed.' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    @jobs = Job.find(params[:id])
    @jobs.update(job_params)
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to partner_jobs_list_path, notice: 'Job was successfully updated.' }
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

    def set_company
      @company = current_partner.company
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.permit(:job, :user_id, :task_id, :company_id, :booking_date, :booking_time, :price, :manual_customers_id, :is_manual_booking, :status, :view_job_id, :post_date, :category_id, :address1, :city, :country, :latitude, :longitude, :address, :properties, :zipcode, :staff_id)
    end

    def task_params
      params.require(:task).permit(:user_id, :category_id, :zipcode, :is_active, :is_manual_booking, :booking_date, :booking_time, :latitude, :longitude, :address, :company_id, :task_type, :address1, :address2, :city, :country, :freq, :properties=>{}, :propertytext=>{})
    end
end
