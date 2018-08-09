class Api::V1::CancelJobController < Api::V1::ApplicationController
	before_action :authenticate_user!
  before_action :ensure_params_exist

	respond_to :json

	def canceljob
    userfind = User.find_by(:id => params[:user_id])
		@job = Job.find_by(:id => params[:job_id])
		@job.update_attributes(:status => "booking_cancelled")
		if @job.update(:status => "booking_cancelled")
				render json: {
									status: 200,
									message: 'The job has been cancelled.',
								}.to_json, status: 200
		else
		render :json => { :success => false, :errorcode => 401, :message => "Error cancelling job" }, :status => 401
		end
	end


		protected


	def ensure_params_exist
		if params[:user_id].present? && params[:job_id].present?
		return
	else
		render :json => { :success => false, :errorcode => 422, :message => "missing user_id or job_id parameter" }, :status => 422
	end
	end

  def job_params
    params.permit(:user_id, :id)
  end

end
