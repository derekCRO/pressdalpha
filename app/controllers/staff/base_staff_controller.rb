class Staff::BaseStaffController < ApplicationController
  layout "staff_panel"
  before_action :authenticate_staff!

  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :is_active, :date) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :current_password, :is_active) }
  end

  def unread_notifications
    @unread_notifications = Notification.where(recipient: current_user).unread
    @unread_notifications_count = @unread_notifications.count
  end

end
