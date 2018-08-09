class Api::V1::UserNotificationsSettingsController < Api::V1::ApplicationController
  before_action :authenticate_user!
  before_action :ensure_params_exist

  respond_to :json

  def findnotificationsettings
    user = User.find_by(id: params[:user_id])
    unless user.nil?
      render status: 200, :json => user.to_json(:only => [:notifications_email,:notifications_push,:notifications_marketing])
  end
  end

  def updatenotificationsettings
    @user = User.find_by(id: params[:user_id])
    @user.update(notifications_email: params[:notifications_email], notifications_push: params[:notifications_push], notifications_marketing: params[:notifications_marketing])
    if @user.nil?
      render json: { success: false, errorcode: 401, message: 'Error processing details' }, status: 401
    else
      render json: { success: true, errorcode: 200, message: 'User updated' }, status: 200
    end
    end

  protected

  def ensure_params_exist
    return unless params[:user_id].blank?
    render json: { success: false, errorcode: 422, message: 'missing user_login parameter' }, status: 422
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :is_active, :is_admin, :date, :user_type, :notifications_email,:notifications_push,:notifications_marketing, :phone, :about_me, :image, :password, :password_confirmation, :address, :address1, :address2, :city, :country, :zipcode)
  end

end
