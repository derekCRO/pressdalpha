class Partner::NotificationsController < Partner::BasePartnerController
  before_action :authenticate_customer!

  # GET /categories
  # GET /categories.json
  def index
    @notifications = Notification.where(recipient: current_customer).unread
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_customer).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end


  private
    # Use callbacks to share common setup or constraints between actions.

end
