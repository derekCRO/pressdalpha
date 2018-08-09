class Api::V1::MessagesController < Api::V1::ApplicationController
	before_action :authenticate_user!
  before_action :ensure_params_exist

	respond_to :json

	def findmessages
    convofind = Conversation.find_by(:id => params[:conversation_id])
		@messages = Message.where("conversation_id = ?", convofind).order("updated_at DESC").limit(10).offset(params[:offset])
		unless @messages.nil?
				render :json => @messages.to_json(:only => [:body, :sent_by],:methods => [:image_url_thumb, :updated_date, :updated_time])
				return
		end
		render :json => { :success => false, :errorcode => 406, :message => "Incorrect details" }, :status => 406
	end

		protected


	def ensure_params_exist
		return unless params[:conversation_id].blank?
		render :json => { :success => false, :errorcode => 406, :message => "missing message parameters" }, :status => 406
	end

  def message_params
    params.permit(:conversation_id)
  end

end
