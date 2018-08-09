module MessagesHelper
  def self_or_other(message)
    if current_customer.present?
    	message.user_id == current_customer.id ? "self" : "other"
    elsif current_partner.present?
     message.user == current_partner ? "self" : "other"
    elsif current_staff.present?
    	message.user == current_staff ? "self" : "other"
    end
  end

  def message_interlocutor(message)
    message.user == message.conversation.sender ? message.conversation.sender : message.conversation.recipient
  end
end
