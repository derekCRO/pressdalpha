class Api::V1::PricingController < Api::V1::ApplicationController
  skip_before_action :authenticate_user!, raise: false
  before_action :ensure_params_exist
  respond_to :json

  def get_prices
    @company_reference = CompanySelectedCategory.where(category_id: params[:category_id]).where(company_id: params[:company_id]).first
    @hours = params[:total_hours].to_f
    @properties = params[:properties]

    @material_cost = @company_reference.companycatatt.sum(:material_cost)

    @one_off_price = @company_reference.price_per_hour * @hours + @material_cost
    @weekly3 = @company_reference.weekly_price_per_hour_3_months * @hours + @material_cost
    @weekly6 = @company_reference.weekly_price_per_hour_6_months * @hours + @material_cost
    @weekly12 = @company_reference.weekly_price_per_hour_12_months * @hours + @material_cost
    @fornightly3 = @company_reference.fortnightly_price_per_hour_3_months * @hours + @material_cost
    @fornightly6 = @company_reference.fortnightly_price_per_hour_6_months * @hours + @material_cost
    @fornightly12 = @company_reference.fortnightly_price_per_hour_12_months * @hours + @material_cost
    @monthly3 = @company_reference.monthly_price_per_hour_3_months * @hours + @material_cost
    @monthly6 = @company_reference.monthly_price_per_hour_6_months * @hours + @material_cost
    @monthly12 = @company_reference.monthly_price_per_hour_12_months * @hours + @material_cost

    render json: {
      status: 200,
      message: 'Below is a list of prices for this company for different periods. The prices include material cost, the listing is for reference only.',
      one_off: @one_off_price,
      weekly_3_months: @weekly3,
      weekly_6_months: @weekly6,
      weekly_12_months: @weekly12,
      fortnightly_3_months: @fornightly3,
      fortnightly_6_months: @fornightly6,
      fortnightly_12_months: @fornightly12,
      monthly_3_months: @monthly3,
      monthly_6_months: @monthly6,
      monthly_12_months: @monthly12,
      material_cost: @material_cost
    }.to_json, status: 200
    end

  protected

  def ensure_params_exist
    if params[:category_id].blank?
      return render json: {
        status: 406,
        message: 'The category_id parameter is missing'
      }.to_json, status: 406
    end

    if params[:company_id].blank?
      return render json: {
        status: 406,
        message: 'The company_id parameter is missing'
      }.to_json, status: 406
    end

    if params[:total_hours].blank?
      return render json: {
        status: 406,
        message: 'The total_hours parameter is missing'
      }.to_json, status: 406
    end

    if params[:properties].blank?
      return render json: {
        status: 406,
        message: 'The properties parameter is missing'
      }.to_json, status: 406
    end
  end

  def company_selected_category_params
    params.permit(:id, :price_per_hour, :weekly_price_per_hour_3_months, :weekly_price_per_hour_6_months, :weekly_price_per_hour_12_months, :fortnightly_price_per_hour_3_months, :fortnightly_price_per_hour_6_months, :fortnightly_price_per_hour_12_months, :monthly_price_per_hour_3_months, :monthly_price_per_hour_6_months, :monthly_price_per_hour_12_months, :service_type, :category_id, :company_id, companycatatt_attributes: %i[id name field_type hour_per_item required category_id material_cost is_company_support category_attribute_id company_selected_category_parent_id price_per_hour])
   end
end
