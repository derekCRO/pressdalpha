class Message < ApplicationRecord


  belongs_to :conversation
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :recipient, class_name: "Company", foreign_key: "recipient_id"

  has_attached_file :image, styles: {
    small: '150x150>',
    thumb: '50x50',
    search: '248x200',
    detail: '750x283',
    listing: '298x198>'
  }

  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def updated_date
    message = Message.find(id)
    date = message.updated_at.time.to_date.strftime("%d/%m/%Y")
  end

  def updated_time
    message = Message.find(id)
    date = message.updated_at.strftime("%H:%M")
  end

  def image_url_thumb
    image.url(:small)
  end

  validates :body, presence: true

  private

end
