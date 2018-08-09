class Api::V1::DoesConvoExistController < Api::V1::ApplicationController
  before_action :authenticate_user!

	respond_to :json


  def convoexist
    userfind = User.find_by(:id => params[:user_id])
    companyfind = Company.find_by(:id => params[:company_id])
    @conversation = Conversation.where("sender_id = ? AND recipient_id = ?", userfind, companyfind)
    if @conversation.exists?
          render json: {
                    status: 200,
                    message: 'Conversation exists.',
                    conversation: @conversation.as_json(:only => [:id, :is_active])
                  }
    else
    render :json => { :success => false, :errorcode => 404, :message => "Conversation not found" }, :status => 404
    end
  end

		protected


  def conversation_params
    params.permit(:recipient_id, :sender_id, :is_active)
  end

end
