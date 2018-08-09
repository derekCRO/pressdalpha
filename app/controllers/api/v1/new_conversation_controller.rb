class Api::V1::NewConversationController < Api::V1::ApplicationController
  before_action :authenticate_user!

	respond_to :json

	def create
		@conversation = Conversation.new(:recipient_id => params[:company_id], :sender_id => params[:user_id], :is_active => true)
    respond_to do |format|
      if @conversation.save
        format.json { render json: @conversation, status: :created }
      else
        format.json { render :json => { :success => false, :errorcode => 422, :message => "Paramaters incorrect - registration failed" }, :status => 422 }

      end
    end
  end

		protected


  def conversation_params
    params.permit(:recipient_id, :sender_id, :is_active)
  end

end
