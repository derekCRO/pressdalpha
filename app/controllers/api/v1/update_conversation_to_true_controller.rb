class Api::V1::UpdateConversationToTrueController < Api::V1::ApplicationController
  before_action :authenticate_user!

	respond_to :json

  def updateconversation
    @conversation = Conversation.find_by(id: params[:conversation_id])
    @conversation.update(is_active: true)
    if @conversation.nil?
      render json: { success: false, errorcode: 401, message: 'Error processing details' }, status: 401
    else
      render json: { success: true, errorcode: 200, message: 'Conversation is now active' }, status: 200
    end
    end

		protected


  def conversation_params
    params.permit(:conversation_id, :is_active)
  end

end
