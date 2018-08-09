class Api::V1::CreateJobController < Api::V1::ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def createjob
    propertytext_param = eval(params[:propertytext])
    properties_param = eval(params[:properties])
    @task = Task.new(user_id: params[:user_id], company_id: params[:company_id], booking_date: params[:booking_date], booking_time: params[:booking_time], category_id: params[:category_id], properties: properties_param, propertytext: propertytext_param, address1: params[:address1], address2: params[:address2], city: params[:city], zipcode: params[:zipcode])

    if @task.save
      @job = Job.new(user_id: params[:user_id], task_id: @task.id, company_id: params[:company_id], booking_date: params[:booking_date], booking_time: params[:booking_time], price: params[:price], category_id: params[:category_id], properties: properties_param, propertytext: propertytext_param, recurring: params[:recurring], recurring_type: params[:recurring_type], recurring_weeks: params[:recurring_weeks], address1: params[:address1], address2: params[:address2], city: params[:city], zipcode: params[:zipcode], status: 'booking_made')
    else
      render json: { success: false, errorcode: 422, message: 'Parameters incorrect - submission failed.' }, status: 422
    end

    if @job.save
      render json: {
                status: 200,
                message: 'Job submitted succesfully.',
                job: @job.id
              }.to_json
      else
      render json: { success: false, errorcode: 422, message: 'Parameters incorrect - submission failed.' }, status: 422
    end

    if params[:recurring] == 'true'
       @subscription = Subscription.new(recurring_type: params[:recurring_type], first_job_id: @job.id, recurring_weeks_in_month: params[:recurring_weeks], recurring_months: params[:recurring_months], date_of_first_booking: params[:booking_date], recurring_price: params[:price], user_id: params[:user_id], partner_id: params[:partner_id], company_id: params[:company_id], category_id: params[:category_id])
    end

    if @subscription && @subscription.save
        @job.update(subscription_id: @subscription.id)
    end
end


  protected

  def job_params
    params.permit(:user_id, :task_id, :recurring_months, :company_id, :booking_date, :booking_time, :price, :status, :category_id, :properties, :zipcode, :address1, :address2, :city, :country, :propertytext, :recurring, :recurring_type, :recurring_weeks, :subscription_id)
  end

end
