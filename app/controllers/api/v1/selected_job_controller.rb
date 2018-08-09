class Api::V1::SelectedJobController < Api::V1::ApplicationController
	before_action :authenticate_user!
  before_action :ensure_params_exist

	respond_to :json

	def findjob
    userfind = User.find_by(:id => params[:user_id])
		jobfind = Job.find_by(:id => params[:job_id])
		@job = Job.where("jobs.user_id = ? AND jobs.id = ?", userfind, jobfind).joins(:company, :category).select("jobs.id, jobs.company_id, jobs.category_id, jobs.booking_date, jobs.booking_time, jobs.address1, jobs.address2, jobs.city, jobs.zipcode, jobs.price, jobs.status, jobs.properties, jobs.propertytext, jobs.recurring, jobs.recurring_type, jobs.recurring_weeks, jobs.subscription_id")
		unless @job.nil?
				render json: {
									status: 200,
									message: 'Below is a list of completed jobs',
									render: @job.as_json(:include => {:company => {:only => :company_name, :methods=> :image_url_thumb}, :category => {:only => :name}})
								}.to_json, status: 200
				return
		end
		render :json => { :success => false, :errorcode => 401, :message => "Incorrect details" }, :status => 401
	end

		protected


	def ensure_params_exist
		return unless params[:user_id].blank?
		render :json => { :success => false, :errorcode => 422, :message => "missing user_id parameter" }, :status => 422
	end

  def job_params
    params.permit(:user_id)
  end

end
