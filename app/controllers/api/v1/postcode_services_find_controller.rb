class Api::V1::PostcodeServicesFindController < Api::V1::ApplicationController
	skip_before_action :authenticate_user!, raise: false
	respond_to :json

	def index
	# fetch company ids based on postcode
	@postcode = params[:postcode]
	company_ids = CompaniesPostcode.joins(:postcode).where("postcodes.name = ?", @postcode).pluck(:company_id)
	selected_categories = CompanySelectedCategory.joins(:category).where("company_id in (?)", company_ids).select("categories.id")
	categories = Category.where("id in (?)", selected_categories).select("categories.id, categories.name")
	company_count = company_ids.count
					render json: {
										status: 200,
										message: 'Below is a list of categories',
										categories: categories.as_json(methods: [:mobile_cover_image_url, :mobile_icon_url]),
										company_count: company_count
									}.to_json, status: 200
	end

protected

def ensure_params_exist
return unless params[:postcode].blank?
render :json => { :success => false, :errorcode => 422, :message => "missing cat id paramater" }, :status => 422
end

def task_params
  params.require(:task).permit(:user_id, :category_id, :zipcode, :is_active, :booking_date, :booking_time, :latitude, :longitude, :address, :company_id, :task_type, :address1, :address2, :city, :country, :properties=>{}, :propertytext=>{})
end

end
