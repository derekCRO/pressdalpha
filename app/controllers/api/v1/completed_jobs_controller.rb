class Api::V1::CompletedJobsController < Api::V1::ApplicationController
	before_action :authenticate_user!
  before_action :ensure_params_exist

	respond_to :json

	def findjobs
    userfind = User.find_by(:id => params[:user_id])
		@jobs = Job.where("jobs.user_id = ?", userfind).where(status: ['booking_complete', 'booking_paid', 'booking_cancelled']).joins(:company, :category).select("jobs.id, jobs.company_id, jobs.category_id, jobs.booking_date, jobs.booking_time, jobs.properties, jobs.propertytext")
		unless @jobs.nil?
				render json: {
									status: 200,
									message: 'Below is a list of completed jobs',
									render: @jobs.as_json(:include => {:company => {:only => :company_name, :methods=> :image_url_thumb}, :category => {:only => :name}})
								}.to_json, status: 200
				return
		end
		render json: {
							status: 204,
							message: 'There are no completed jobs for this user_id'
						}.to_json, status: 204
	end

		protected


	def ensure_params_exist
		return unless params[:user_id].blank?
		render json: {
							status: 406,
							message: 'The user_id parameter is missing'
						}.to_json, status: 406
	end


  def job_params
    params.permit(:user_id)
  end

end
