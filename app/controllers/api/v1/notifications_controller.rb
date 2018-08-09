class Api::V1::NotificationsController < Api::V1::ApplicationController
  before_action :authenticate_user!

  # GET /categories
  # GET /categories.json
  def notificationcount
    userfind = User.find_by(:id => params[:user_id])
    @notifications = Notification.where("recipient_id = ?", userfind).unread.count

    render status: 200, json: {
    message: "Notification Count Success.",
    notificationcount: @notifications
    }.to_json

  end

  def notificationsunreadlist
    userfind = User.find_by(:id => params[:user_id])
    @notifications = Notification.where("recipient_id = ?", userfind).unread
    render status: 200, json: {
    message: "Notifications Success.",
    notifications: @notifications
    }.to_json

  end

  def updatesinglenotification
    userfind = User.find_by(:id => params[:user_id])
    notificationid = Notification.find_by(:id => params[:notification_id]).where("stuck = ?", false)
    notificationid.update(read_at: params[:read_at_date])
    if notificationid.nil?
    render status: 406, json: {
    message: "Incorrect paramaters - no notification ID.",
    }.to_json
    else
    render status: 200, json: {
    message: "Notification updated to read at.",
    }.to_json
  end
end

def updateallundreadnotifications
  userfind = User.find_by(:id => params[:user_id])
  @notifications = Notification.where("recipient_id = ?", userfind).where("stuck = ?", false).unread
  @notifications.update(read_at: params[:read_at_date])
  if userfind.nil?
  render status: 406, json: {
  message: "Incorrect parameters - no User ID.",
  }.to_json
  else
  render status: 200, json: {
  message: "Notifications all updated to read at..",
  }.to_json
end
end

  protected
    # Use callbacks to share common setup or constraints between actions.

end
