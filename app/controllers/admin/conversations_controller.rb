  class Admin::ConversationsController < Admin::BaseAdminController

  def index
    @conversations = Conversation.all
    end

  def messagespage
    @conversation = Conversation.find(params[:id])
    @messages = Message.where(conversation_id: @conversation.id)
    end

end
