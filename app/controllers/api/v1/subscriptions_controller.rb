class Api::V1::SubscriptionsController < Api::V1::ApplicationController
	before_action :authenticate_user!
  before_action :ensure_params_exist

	respond_to :json

		def findallsubscriptions
	    userfind = User.find_by(:id => params[:user_id])
			@subscriptions = Subscription.where("subscriptions.user_id = ?", userfind).joins(:company, :category).select("subscriptions.id, subscriptions.recurring_type,subscriptions.recurring_weeks_in_month,subscriptions.recurring_months,subscriptions.first_job_id,subscriptions.date_of_first_booking,subscriptions.recurring_price,subscriptions.user_id,subscriptions.partner_id,subscriptions.company_id,subscriptions.category_id")
			unless @subscriptions.nil?
					render status: 200, :json => @subscriptions, :include => {:company => {:only => :company_name, :methods=> :image_url_thumb}, :category => {:only => :name}}
					return
			end
			render :json => { :success => false, :errorcode => 401, :message => "Incorrect details" }, :status => 401
		end

		def findsinglesubscription
			userfind = User.find_by(:id => params[:user_id])
			subscriptionfind = Subscription.find_by(:id => params[:subscription_id])
			@subscriptions = Subscription.where("subscriptions.user_id = ?", userfind).where("subscriptions.id = ?", subscriptionfind).joins(:company, :category).select("subscriptions.id, subscriptions.recurring_type,subscriptions.recurring_weeks_in_month,subscriptions.recurring_months,subscriptions.first_job_id,subscriptions.date_of_first_booking,subscriptions.recurring_price,subscriptions.user_id,subscriptions.partner_id,subscriptions.company_id,subscriptions.category_id")

			unless @subscriptions.nil?
					render status: 200, :json => @subscriptions, :include => {:company => {:only => :company_name, :methods=> :image_url_thumb}, :category => {:only => :name}}
					return
			end
			render :json => { :success => false, :errorcode => 401, :message => "Incorrect details" }, :status => 401
		end




	def ensure_params_exist
		return unless params[:user_id].blank?
		render :json => { :success => false, :errorcode => 422, :message => "missing user_id parameter" }, :status => 422
	end

  def job_params
    params.permit(:user_id)
  end

end
