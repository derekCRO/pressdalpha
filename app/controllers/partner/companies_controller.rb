class Partner::CompaniesController < Partner::BasePartnerController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @companies = Company.find(params[:id])
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @getUser = User.where(:email => company_params[:email]).first

    respond_to do |format|
     if @getUser
      format.html { render :new }
      format.json { render :json => @company, status => "error", message => "Email address already exist." }
     else
      if @company.save
        format.html { redirect_to '/admin/companies/', notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
     end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    params[:company][:postcode_ids] ||=[]
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to '/admin/companies/', notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to '/admin/companies/', notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def company_profile
    @company = Company.where(user_id: current_partner.id).first
    @companylocation = Companylocation.where(company_id: @company.id)
  end


  def companyprofileupdate
    Rails.logger.debug("Resource: #{@company}")
    # @company = Company.where(user_id: current_partner.id).first
    @company = current_partner.company
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to '/partner/companies/company_profile/', notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_hours
    @events = current_partner.events
  end

  def rota_list
    @company = current_partner.company
    if current_partner.company.staff_rotas_enable
      @events = current_partner.events({staff_count: true})
    else
      @events = current_partner.events()
    end
  end

  def save_staff_counts
    @company = current_partner.company
    @staffs = Staff.where(id: params[:staff_ids])
    start_time = DateTime.parse(params[:start_time]).strftime("%I:%M")
    end_time = DateTime.parse(params[:end_time]).strftime("%I:%M")
    @week_day = Date.parse(params[:start_time]).wday+1
    @staffs.each do |staff|
      time_slots = staff.time_slots.find_by(
        "starting_time::time = ? AND ending_time::time = ?",start_time,end_time
      )
      unless time_slots.present?
        @time_slots = staff.time_slots.new
        @time_slots.starting_time = start_time
        @time_slots.ending_time = end_time
        @time_slots.week_day_id = @week_day
      end
    end
    redirect_to '/partner/companies/rota-list'
  end

  def save_hours
    if request.post?
      current_partner.save_hours(params[:week_day], params[:start], params[:end])
    else
      company_time_slot = TimeSlot.find(params[:id])
      if params[:week_day].present? && params[:start].present?
        day = WeekDay.find_by(day_name: params[:week_day])
        company_time_slot.update(week_day_id: day.id, starting_time: params[:start], ending_time: params[:end])
      else
        company_time_slot.update(ending_time: params[:end])
      end
    end
    @events = current_partner.events
  end

  def destroy_hours
    @time_slot = TimeSlot.find(params[:id])
    @time_slot.destroy
    @events = current_partner.events
    # respond_to do |format|
    #   format.html { redirect_to '/admin/companies/add-hours', notice: 'Time slot was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:is_active, :company_name, :about_company, :location, :image, :servicearea_radius, :servicestart_time, :serviceend_time, :service_type, :staff_rotas_enable, {postcode_ids: []})
    end
end
