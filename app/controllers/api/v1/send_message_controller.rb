class Api::V1::SendMessageController < Api::V1::ApplicationController
	before_action :authenticate_user!
  before_action :ensure_params_exist

	respond_to :json

	def sendmessage
		@message = Message.create(:conversation_id => params[:conversation_id], :body => params[:body], :user_id => params[:user_id], :image => params[:image], :recipient_id => params[:company_id], :sent_by => 'customer')
		if @message.save
				render :json => @message.to_json(:methods => [:image_url_thumb])
		else
		render :json => { :success => false, :errorcode => 401, :message => "Incorrect details" }, :status => 401
	end
	end

		protected


	def ensure_params_exist
		return unless params[:conversation_id].blank?
		render :json => { :success => false, :errorcode => 422, :message => "missing user_login parameter" }, :status => 422
	end

  def message_params
    params.permit(:id, :message, :conversation_id, :body,:user_id, :image, :created_at, :updated_at, :recipient_id)
  end

end
