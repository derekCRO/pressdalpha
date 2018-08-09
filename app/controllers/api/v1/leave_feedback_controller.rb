class Api::V1::LeaveFeedbackController < Api::V1::ApplicationController
  before_action :authenticate_user!
  before_action :ensure_params_exist

	respond_to :json

	def newcompanyrating
		@job = Job.find_by(:id => params[:job_id])
    @companyrating = CompanyRating.new(:job_id => params[:job_id], :user_id => params[:user_id], :company_id => params[:company_id], :score => params[:score])

    respond_to do |format|
      if @companyrating.save
        @job.update(rating_given: "true")
        format.json { render :json => { :success => true, :errorcode => 200, :message => "Company Rating submitted succesfully. " }, :status => 200 }
      else
        format.json { render :json => { :success => false, :errorcode => 406, :message => "Paramaters incorrect - submission failed." }, :status => 406 }
      end
    end
  end

		protected

    def ensure_params_exist
      return unless params[:job_id].blank? or params[:user_id].blank? or params[:company_id].blank? or params[:score].blank?
      render json: {
                status: 406,
                message: 'You have a parameter missing'
              }.to_json, status: 406
    end

  private

  def company_rating_params
    params.permit(:job_id, :user_id, :company_id, :score)
  end
end
