class Staff::CompaniesController < Staff::BaseStaffController
  before_action :set_staff_company, only: [:show, :edit, :update, :destroy]

  # GET /staff/companies
  # GET /staff/companies.json
  def index
    @staff_companies = Staff::Company.all
  end

  # GET /staff/companies/1
  # GET /staff/companies/1.json
  def show
  end

  # GET /staff/companies/new
  def new
    @staff_company = Staff::Company.new
  end

  # GET /staff/companies/1/edit
  def edit
  end

  # POST /staff/companies
  # POST /staff/companies.json
  def create
    @staff_company = Staff::Company.new(staff_company_params)

    respond_to do |format|
      if @staff_company.save
        format.html { redirect_to @staff_company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @staff_company }
      else
        format.html { render :new }
        format.json { render json: @staff_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staff/companies/1
  # PATCH/PUT /staff/companies/1.json
  def update
    respond_to do |format|
      if @staff_company.update(staff_company_params)
        format.html { redirect_to @staff_company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @staff_company }
      else
        format.html { render :edit }
        format.json { render json: @staff_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staff/companies/1
  # DELETE /staff/companies/1.json
  def destroy
    @staff_company.destroy
    respond_to do |format|
      format.html { redirect_to staff_companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_hours
    @events = current_staff.events
  end

  def save_hours
    if request.post?
      week_day = WeekDay.find_by(day_name: params[:week_day])
      @new_time_slot = current_staff.save_staff_hours(week_day, params[:start], params[:end], params[:working_date])
    else
      company_time_slot = TimeSlot.find(params[:id])
      company_time_slot.update(ending_time: params[:end])
      @new_time_slot = company_time_slot
    end
    @events = current_staff.events
  end


  def duplicate_working_hours
    @hours = current_staff.time_slots.where(id: params[:hour_ids])
    @ids = []
    @conflicting_hours = []
    @hours.each do |hour|
      puts "----------------",((Date.today()+27.weeks).cweek-hour.working_date.to_date.cweek)-1
      (1..((Date.today()+27.weeks).cweek-hour.working_date.to_date.cweek)-1).each do |i|
        puts "*******", i
        new_time_slot = hour.dup
        @current_week_date = new_time_slot.working_date
        new_time_slot.working_date = new_time_slot.working_date + (7*i).days
        start_day_of_week = new_time_slot.working_date.beginning_of_week
        end_day_of_week = new_time_slot.working_date.end_of_week
        next_week_data = current_staff.time_slots.where( working_date: start_day_of_week..end_day_of_week, week_day_id: hour.week_day_id )

        if next_week_data.present?
          next_week_data.each do |ts|
            if new_time_slot.starting_time.between?(ts.starting_time, ts.ending_time)
              @ids << ts.id
              @conflicting_hours << hour.id
            elsif new_time_slot.ending_time.between?(ts.starting_time, ts.ending_time)
              @ids << ts.id
              @conflicting_hours << hour.id
            elsif new_time_slot.starting_time > ts.starting_time && new_time_slot.starting_time < ts.ending_time
              @ids << ts.id
              @conflicting_hours << hour.id
            elsif new_time_slot.starting_time < ts.starting_time && new_time_slot.ending_time > ts.ending_time
              @ids << ts.id
              @conflicting_hours << hour.id
            elsif new_time_slot.new_record?
              new_time_slot.save!
            end
          end
        else
          staff_new_time_slot = current_staff.time_slots.find_or_initialize_by(new_time_slot.attributes.except!( "id", "created_at", "updated_at"))
          if staff_new_time_slot.new_record?
            staff_new_time_slot.save!
          else
            @ids << staff_new_time_slot.id
            @conflicting_hours << hour.id
          end
        end
        @new_week_date = new_time_slot.working_date
      end
    end
    @events = current_staff.events
  end

  def re_assign_slot
    current_time_slots = current_staff.time_slots.where(id: params[:new_slot])
    puts current_time_slots.pluck(:week_day_id).uniq
    existing_time_slots = current_staff.time_slots.where(id: params[:existing_slot], week_day_id: current_time_slots.pluck(:week_day_id).uniq)
    current_time_slots.each do |current_slot|
      new_dup = current_slot.dup
      new_dup.working_date = new_dup.working_date + 7.days
      new_dup.save!
    end
    existing_time_slots.destroy_all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff_company
      @staff_company = Staff::Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_company_params
      params.fetch(:staff_company, {})
    end
end
