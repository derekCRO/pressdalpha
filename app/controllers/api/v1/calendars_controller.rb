class Api::V1::CalendarsController < Api::V1::ApplicationController
  skip_before_action :authenticate_user!, raise: false
  respond_to :json

  def get_days
    @companies_with_green, @companies_with_orange = get_companies_data(params[:zipcode][0...4], params[:properties], params[:total_hours])
    eventDates = {}
    hash_test = {}
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    green_dates = []
    orange_dates = []
    @green_time_slots = TimeSlot.where(user_slotable: @companies_with_green).pluck(:week_day_id).uniq.map { |d| d -= 1 }
    @orange_time_slots = TimeSlot.where(user_slotable: @companies_with_orange).pluck(:week_day_id).uniq.map { |d| d -= 1 }

    (start_date..end_date).each do |date|
      puts date.wday
      if @green_time_slots.include?(date.wday)
        green_dates << date
      elsif @orange_time_slots.include?(date.wday)
        orange_dates << date
      end
    end

    all_dates = { green_dates: green_dates, orange_dates: orange_dates }

    render json: {
      status: 200,
      message: 'Below is a list of all dates requested',
      green_dates: green_dates,
      orange_dates: orange_dates
    }.to_json, status: 200
  end

  def get_time_slots
    @companies_with_green, @companies_with_orange = get_companies_data(params[:zipcode][0...4], params[:properties], params[:total_hours])
    start_date = params[:date]
    @week_day =  Date.parse(params[:date]).wday + 1

    @green_time_slots = TimeSlot.where(user_slotable: @companies_with_green, week_day_id: @week_day).pluck(:starting_time, :ending_time).map { |t| { start_time: t[0].to_s(:time), end_time: t[1].to_s(:time) } }
    @orange_time_slots = TimeSlot.where(user_slotable: @companies_with_orange, week_day_id: @week_day).pluck(:starting_time, :ending_time).map { |t| { start_time: t[0].to_s(:time), end_time: t[1].to_s(:time) } }

    render json: {
      status: 200,
      message: 'Below is a list of all time slots requested',
      green_time_slots: @green_time_slots,
      orange_time_slots: @orange_time_slots
    }.to_json, status: 200
  end

  #
  # #Def to get orange and green companies
  #
  def get_companies_data(zipcode, properties, p_total_hours)
    @zipcode = zipcode
    company_ids = CompaniesPostcode.joins(:postcode).where('postcodes.name = ?', @zipcode[0...4]).pluck(:company_id)

    @selected_categories = CompanySelectedCategory.joins(:category)\
                                                  .where('company_id in (?)', company_ids).select('categories.id, categories.name, categories.image_file_name')

    @companies = Company.all
    # render json: @companies
    # @task = Task.find(params[:id])
    @prop = eval(properties)
    @prop.to_a
    @text = {}

    sub_cat_id = []
    sub_cat_att_id = []
    answered_values = []
    @total_hours = 0
    @prop.each do |k, v|
      @cat = Category.find(k)
      v.to_a
      a = {}
      sub_cat_id << k
      v.each do |smk, smv|
        sub_cat_att_id << smk
        # puts "--smk: #{smk} and smv: #{smv}"
        smk1 = smk.to_i
        smk = smk.to_i unless smk =~ /[^[:digit:]]+/
        # puts "Check number #{smk1} --- #{smk} "
        if smk.is_a? Integer
          @attr = CategoryAttribute.find(smk)
          unless @attr.blank?
            # puts "a == #{a}"
            if @attr.field_type == 'check_box'
              if smv == '1'
                @total_hours += @attr.hour_per_item.to_i
                @opt = 'Yes'
                answered_values << true
              else
                @opt = 'No'
                answered_values << false
              end
              a[@attr.name] = @opt
            elsif @attr.field_type == 'text_field'
              @total_hours += @attr.hour_per_item.to_i
              a[@attr.name] = smv
            elsif @attr.field_type == 'number_field'
              @total_hours += @attr.hour_per_item.to_i
              a[@attr.name] = smv
            elsif @attr.field_type == 'radio'
              @total_hours += @attr.hour_per_item.to_i
            end
          end

        else
          puts "--smk: #{smk} and smv: #{smv}"
          @attr = CategoryAttribute.find(smv)
          a[@attr.group_name] = @attr.name unless @attr.blank?
        end
        @text[@cat.name] = a
      end
    end

    selected_attr = CompanySelectedCategoryAttribute.where(category_id: sub_cat_id)
    @company_ids = selected_attr.pluck(:company_id).uniq
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

    @days = Company.where(id: @companies.values.flatten.pluck(:company_id)).map { |company| company.time_slots.map { |ts| ts if (ts.ending_time.hour - ts.starting_time.hour) >= p_total_hours.to_i }.reject(&:nil?).group_by(&:user_slotable_id) }.reject(&:blank?)

    green_dates = []
    orange_dates = []
    @companies_with_green = Company.where(id: @green_companies)

    @companies_with_orange = Company.where(id: @orange_companies)

    [@companies_with_green, @companies_with_orange]
  end

  # private
  #   def comment_params
  # 		params.require(:comment).permit(:user_id, :content )
  #   end
end
