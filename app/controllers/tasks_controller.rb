class TasksController < ApplicationController
  before_action :store_user_location!, if: :storable_location?
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_customer!, :only => [:step6]
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  def step1
    @task = Task.new
  end

  def step2
    # @categories = Category.where(category_id: 0).order("id DESC")
    @task = Task.find(params[:id])
    @postcode = @task.zipcode
    # fetch company ids based on postcode
    company_ids = CompaniesPostcode.joins(:postcode).where("postcodes.name = ?", @postcode[0...4]).pluck(:company_id)

    categorieslookup = Category.joins(:company_selected_category).where("company_selected_categories.company_id in (?)", company_ids).pluck(:category_id)

    @categories = Category.where("category_id in (?)", categorieslookup).where(:is_active =>  true).select("categories.id, categories.name, categories.image_file_name")

  end

  def step3
    @task = Task.find(params[:id])
    @postcode = @task.zipcode
    @id = params[:cid]
    @category = Category.find(params[:cid])
    @subcategories = Category.includes(:questions).where(category_id: @id)
  end

  def step3update
    @task = Task.find(params[:id])
    respond_to do |format|
      #task_params[:propertytext] = task_params[:propertytext].to_hash
      if @task.update(task_params)
        @tassk = Task.find(params[:id])
        @prop = @tassk.properties
        @prop.to_a
        @text = Hash.new

        puts "A fruit of type: #{@prop}"
        sub_cat_id = []
        sub_cat_att_id = []
        @prop.each do |k,v|
          #puts "Id: #{k} and V: #{v}"
          # @cat = Category.find(k)
          #@text.push(@cat.name)
          #@text = @text+'<p><i class="fa-icon-ok text-contrast"></i> <span>Supplement Questions</span></p>'
          # v.to_a
          a = Hash.new
          sub_cat_id << k
          # v.each do |smk,smv|
          #   sub_cat_att_id << smk
          #   #puts "--smk: #{smk} and smv: #{smv}"
          #   smk1 = smk.to_i
          #   smk = smk.to_i unless smk.match(/[^[:digit:]]+/)
          #   #puts "Check number #{smk1} --- #{smk} "
          #   if smk.is_a? Integer
          #     @attr = CategoryAttribute.find(smk)
          #     if !@attr.blank?
          #       #puts "a == #{a}"
          #       if @attr.field_type == 'check_box'
          #         if smv=='1'
          #           @opt = 'Yes'
          #         else
          #           @opt = 'No'
          #         end
          #         a[@attr.name] = @opt
          #       elsif (@attr.field_type == 'text_field')
          #         a[@attr.name] = smv
          #       elsif (@attr.field_type == 'number_field')
          #         a[@attr.name] = smv
          #       elsif (@attr.field_type == 'radio')
          #         #a[@attr.name] = smv
          #       end
          #     end
          #
          #   else
          #     puts "--smk: #{smk} and smv: #{smv}"
          #     @attr = CategoryAttribute.find(smv)
          #     if !@attr.blank?
          #       #puts "a == #{a}"
          #       a[@attr.group_name] = @attr.name
          #
          #     end
          #   end
          #   # @text[@cat.name] = a
          # end
        end
        @text = @text.to_hash
        puts "task test #{@text}"
        Task.where(id: @tassk.id).update(propertytext: @text)
        format.html { redirect_to tasks_step4_path(id: @task, cid: params[:cid])}
        format.json { render :step4, status: :ok, location: @task }
      else
        format.html { render :step3 }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def step4
    @task = Task.find(params[:id])
    @prop = @task.properties
    @prop.to_a
    @text = Hash.new

    puts "A fruit of type: #{@prop}"
    sub_cat_id = []
    sub_cat_att_id = []
    answered_values = []
    @total_hours = 0
    @prop.each do |k,v|
      p "----------",k
      p "----------",v
      if k == "category_id"
        @cat = Category.find(v)
      end
      v.to_a
      a = Hash.new
      sub_cat_id << k
      v.each do |smk,smv|
        sub_cat_att_id << smk
        #puts "--smk: #{smk} and smv: #{smv}"
        smk1 = smk.to_i
        smk = smk.to_i unless smk.match(/[^[:digit:]]+/)
        #puts "Check number #{smk1} --- #{smk} "
        if smk.is_a? Integer
          @attr = CategoryAttribute.find(smk)
          if !@attr.blank?
            #puts "a == #{a}"
            if @attr.field_type == 'check_box'
              if smv=='1'
                @total_hours += @attr.hour_per_item.to_i
                @opt = 'Yes'
                answered_values << true
              else
                @opt = 'No'
                answered_values << false
              end
              a[@attr.name] = @opt
            elsif (@attr.field_type == 'text_field')
              @total_hours += @attr.hour_per_item.to_i
              a[@attr.name] = smv
            elsif (@attr.field_type == 'number_field')
              @total_hours += @attr.hour_per_item.to_i
              a[@attr.name] = smv
            elsif (@attr.field_type == 'radio')
              @total_hours += @attr.hour_per_item.to_i
              #a[@attr.name] = smv
            end
          end

        else
          puts "--smk: #{smk} and smv: #{smv}"
          @attr = CategoryAttribute.find(smv)
          if !@attr.blank?
            #puts "a == #{a}"
            a[@attr.group_name] = @attr.name

          end
        end
        if @cat.present?
          @text[@cat.name] = a
        end
      end
    end


    selected_attr = CompanySelectedCategoryAttribute.where(category_id: sub_cat_id)
    @company_ids = selected_attr.pluck(:company_id).uniq
    # @companies = Company.where(id: company_ids).map{ |company| company.time_slots.group_by(&:user_slotable_id) }
    @companies = CompanySelectedCategoryAttribute.where(company_id: @company_ids).group_by(&:company_id)
    @green_companies = []
    @orange_companies = []
    @companies.each do |comp, values|
      if values.pluck(:is_company_support) == answered_values
        @green_companies << comp
      elsif values.pluck(:is_company_support).include?(true)
        @orange_companies << comp
      end
    end


    @days = Company.where(id: @companies.values.flatten.pluck(:company_id)).map{|company| company.time_slots.map{|ts| ts if (ts.ending_time.hour - ts.starting_time.hour) >= @total_hours}.reject{|ele| ele.nil?}.group_by(&:user_slotable_id)}.reject{|day| day.blank?}

    # @time_slots = Company.where(id: @company_ids).map{|company| company.time_slots.group(:id, :user_slotable_id).map{|company| company.week_day.day_name}}.flatten.uniq
    puts "time slots #{@time_slots}"

    @text = @task.propertytext
    @id = params[:cid]
    @category = Category.find(params[:cid])
    @subcategories = Category.where(category_id: @id)
  end

  def step4update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_step5_path(id: @task, cid: params[:cid])}
        format.json { render :step4, status: :ok, location: @task }
      else
        format.html { render :step3 }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def step5
    @task = Task.find(params[:id])
    @text = @task.propertytext
    @id = params[:cid]
    @category = Category.find(@id)
    @subcategories = Category.where(category_id: @id)
    @compQuotations = CompanySelectedCategory.where(category_id: @id, service_type: 'Quotation')
    @compDirect = CompanySelectedCategory.where.not(service_type: 'Quotation').where(category_id: @id)
    @company = Company.where(is_active: true)
  end

  def step5update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_step6_path(id: @task, cid: params[:cid])}
        format.json { render :step4, status: :ok, location: @task }
      else
        format.html { render :step3 }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def step6
    @task = Task.find(params[:id])
    @id = params[:cid]
    @user = User.find(current_customer.id)
    @category = Category.find(@id)
    @subcategories = Category.where(category_id: @id)
    @compQuotations = CompanySelectedCategory.where(category_id: @id,service_type: 'Quotation')
    @compDirect = CompanySelectedCategory.where.not(service_type: 'Quotation').where(category_id: @id)
    @company = Company.where(is_active: true)
  end

  def step6update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        customer = Stripe::Customer.create({
          email: current_customer.email,
          source: params[:stripeToken],
        })

        current_customer.update(stripe_id: customer.id, card_type: customer["sources"]["data"][0]["brand"], card_exp_year: customer["sources"]["data"][0]["exp_year"], card_exp_month: customer["sources"]["data"][0]["exp_month"], card_last4: customer["sources"]["data"][0]["last4"])

        format.html { redirect_to jobs_save_path(id: @task, cid: params[:cid])}
        format.json { render :step4, status: :ok, location: @task }
      else
        format.html { render :step3 }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    @zipcode = params[:task][:zipcode][0...4]
    company_ids = CompaniesPostcode.joins(:postcode).where("postcodes.name = ?", @zipcode[0...4]).pluck(:company_id)
    @selected_categories = CompanySelectedCategory.joins(:category).\
    where("company_id in (?)", company_ids).select("categories.id, categories.name, categories.image_file_name")

    respond_to do |format|
      if @selected_categories.size > 0
        if @task.save(task_params)
          format.html { redirect_to tasks_step2_url(id: @task)}
          format.json { render :step2, status: :ok, location: @task }
        else
          format.html { render :step1 }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to tasks_step1_url,  notice: 'No result.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_time_slots
    @company = Company.find(params[:c_id])
    @time_slots = @company.time_slots.where(week_day_id: params[:day].to_i+1)
    @business_hours = @company.partner.available_slots
    @business_hours = @business_hours[0].map{ |hour| hour if hour[:dow][0].to_i == params[:day].to_i }.reject{|hour| hour.nil?}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:user_id, :category_id, :zipcode, :is_active, :booking_date, :booking_time, :latitude, :longitude, :address, :company_id, :task_type, :address1, :address2, :city, :country, :freq, :properties=>{}, :propertytext=>{})
  end

  def integer?
    [                          # In descending order of likeliness:
      /^[-+]?[1-9]([0-9]*)?$/, # decimal
      /^0[0-7]+$/,             # octal
      /^0x[0-9A-Fa-f]+$/,      # hexadecimal
      /^0b[01]+$/              # binary
    ].each do |match_pattern|
      return true if self =~ match_pattern
    end
    return false
  end

end
