class Conversation < ApplicationRecord

  has_many :messages, dependent: :destroy
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "Company", foreign_key: "recipient_id"

  validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  def self.get(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def opposed_user(user)
    user == recipient ? sender : recipient
  end

  def latestmessage
    conversation = Conversation.find(id)
    message = conversation.messages.last(1).as_json(:only => [:body, :sent_by],:methods => [:image_url_thumb, :updated_date, :updated_time])
  end

  def recipientimage
    conversation = Conversation.find(id)
    image = conversation.recipient.image_url_thumb
  end

  def senderimage
    conversation = Conversation.find(id)
    image = conversation.sender.image_url_thumb
  end

  def companyname
    conversation = Conversation.find(id)
    image = conversation.recipient.company_name
  end

  def updated_date
    conversation = Conversation.find(id)
    date = conversation.updated_at.time.to_date.strftime("%d/%m/%Y")
  end

  def updated_time
    conversation = Conversation.find(id)
    date = conversation.updated_at.strftime("%H:%M")
  end

  private

end
