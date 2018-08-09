class Staff::NotificationsController < Staff::BaseStaffController
  before_action :authenticate_staff!

  # GET /categories
  # GET /categories.json
  def index
    @notifications = Notification.where(recipient: current_staff).unread
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_staff).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end


  private
    # Use callbacks to share common setup or constraints between actions.

end
