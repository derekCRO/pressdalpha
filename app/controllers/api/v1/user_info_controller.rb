class Api::V1::UserInfoController < Api::V1::ApplicationController
  before_action :authenticate_user!
  before_action :ensure_params_exist

  respond_to :json

  def finddetails
    customer = Customer.find_by(id: params[:user_id])
    unless customer.nil?
      render json: customer.to_json(methods: [:image_url_thumb])
      return
    end
    render json: { success: false, errorcode: 401, message: 'Incorrect details' }, status: 401
  end

  def updateaccount
    @user = User.find_by(id: params[:user_id])
    @user.update(first_name: params[:first_name], last_name: params[:last_name], phone: params[:phone], about_me: params[:about_me],
                 address1: params[:address1], address2: params[:address2], city: params[:city], country: params[:country], zipcode: params[:zipcode], image: params[:image])
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
    params.permit(:id, :first_name, :last_name, :email, :is_active, :is_admin, :date, :user_type, :phone, :about_me, :image, :password, :password_confirmation, :address, :address1, :address2, :city, :country, :zipcode)
  end
end
