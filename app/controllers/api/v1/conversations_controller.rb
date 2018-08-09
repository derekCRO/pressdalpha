class Api::V1::ConversationsController < Api::V1::ApplicationController
	before_action :authenticate_user!
  before_action :ensure_params_exist

	respond_to :json

	def findconversations
    userfind = User.find_by(:id => params[:user_id])
		conversations = Conversation.where("sender_id = ?", userfind).where("is_active = ?", true)

		unless conversations.nil?
				render :json => conversations.to_json(:only => [:id, :recipient_id, :sender_id, :is_active],:methods => [:companyname, :recipientimage, :senderimage, :latestmessage])
				return
		end
		render :json => { :success => false, :errorcode => 401, :message => "Incorrect details" }, :status => 401
	end


		protected


	def ensure_params_exist
		return unless params[:user_id].blank?
		render :json => { :success => false, :errorcode => 422, :message => "missing user_login parameter" }, :status => 422
	end

  def conversation_params
    params.permit(:recipient_id, :sender_id, :created_at, :updated_at)
  end

end
