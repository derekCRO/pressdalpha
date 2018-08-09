class Api::V1::CategoryAttributesController < Api::V1::ApplicationController
	skip_before_action :authenticate_user!, raise: false
	before_action :ensure_params_exist
	respond_to :json

      	def index
				@category = Category.where(:category_id => params[:category_id])
	      @subcategories = @category.includes(:questions).where(:category_id => params[:category_id])
				render json: {
									status: 200,
									message: 'Below is a list of questions for this category',
									render: @subcategories.as_json(:include => { :questions => {:include => { :category_attribute_options => {:only => [:id, :options, :option_hours, :option_price] } }, :only => [:id, :name, :information, :field_type, :hour_per_item, :material_cost, :required] } }, :only => [:id, :name])
								}.to_json, status: 200
				end

		protected

    def ensure_params_exist
      return unless params[:category_id].blank?
			render json: {
								status: 406,
								message: 'The category_id parameter is missing'
							}.to_json, status: 406
    end

    def category_attributes_params
        params.permit(:name, :category_id, :information)
      end

end
