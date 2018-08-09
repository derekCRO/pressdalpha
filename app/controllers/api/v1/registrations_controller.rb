class Api::V1::RegistrationsController < Api::V1::ApplicationController
  skip_before_action :authenticate_user!, raise: false
  respond_to :json

  def create

    if params[:email].nil?
      render :status => 400,
             :json => {:message => 'User request must contain the user email.'}
      return
    elsif params[:password].nil?
      render :status => 400,
             :json => {:message => 'User request must contain the user password.'}
      return
    end
    if params[:email]
      duplicate_user = User.find_by_email(params[:email])
      unless duplicate_user.nil?
        render :status => 409,
               :json => {:message => 'Duplicate email. A user already exists with that email address.'}
        return
      end
    end

    customer = Customer.new(customer_params)

    if customer.save

      render :json => customer , :status => 201

      return

    else

      warden.custom_failure!

      render :json => { :success => false, :errorcode => 422, :message => "Paramaters incorrect - registration failed" }, :status => 422

    end
  end

  private

  def customer_params
    params.permit(:email, :password, :password_confirmation, :phone, :first_name, :last_name, :is_active)
  end
end
