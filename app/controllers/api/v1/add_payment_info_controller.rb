class Api::V1::AddPaymentInfoController < Api::V1::ApplicationController
  before_action :authenticate_user!
  before_action :ensure_params_exist

  respond_to :json

  def retrieve_details
    customer = Customer.find_by(id: params[:user_id])
    if customer.stripe_id.nil?
      render json: { success: false, errorcode: 204, message: 'No Card details stored' }, status: 204
    else
      render json: customer.to_json(only: [:stripe_id, :card_last4, :card_type, :card_exp_month, :card_exp_year])
    end
  end

  def add_details
    customer = Customer.find_by(id: params[:user_id])
    customer.update(stripe_id: params[:stripe_id], card_last4: params[:card_last4], card_exp_month: params[:card_exp_month], card_exp_year: params[:card_exp_year],
                 card_type: params[:card_type])
    if customer.update(user_params)
      render json: { success: true, errorcode: 200, message: 'Card details updated' }, status: 200
    else
      render json: { success: false, errorcode: 406, message: 'Missing user_id parameter' }, status: 406
    end
    end

  protected

  def ensure_params_exist
    return unless params[:user_id].blank?
    render json: { success: false, errorcode: 406, message: 'Missing user_id parameter' }, status: 406
  end

  def user_params
    params.permit(:id, :stripe_id, :card_last4, :card_exp_month, :card_exp_year, :card_type)
  end
end
