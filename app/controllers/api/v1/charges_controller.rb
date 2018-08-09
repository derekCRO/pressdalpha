class Api::V1::ChargesController < Api::V1::ApplicationController
  before_action :authenticate_user!

	respond_to :json

   def show
   end

   def new
   end

   def card_exist
     @user = User.find_by(:id => params[:user_id])

     if @user.stripe_id exists?

     render json: {
               status: 200,
               message: 'Customer Card details exist',
               render: @user.as_json(:only => [:id, :card_last4, :card_exp_month, :card_exp_year, :card_type])
             }.to_json, status: 200

      else

      render json: {
                status: 400,
                message: 'No card details exist'
              }.to_json, status: 400
      end
   end

   def create
     @user = User.find_by(:id => params[:user_id])
     customer = Stripe::Customer.create(
        :email => @user.email,
        :source  => params[:stripeToken]
      )

     @stripe_customer = Stripe::Customer.retrieve(customer.id)
     default_card_id = @stripe_customer.default_source
     @default_card = @stripe_customer.sources[:data].find {|x| x[:id] == default_card_id }

     options = {
       stripe_id: customer.id,
       card_last4: @default_card.last4,
       card_exp_month: @default_card.exp_month,
       card_exp_year: @default_card.exp_year,
       card_type: @default_card.brand
     }

     @user.update(options)

     if @user.update(user_params)

     render json: {
               status: 200,
               message: 'Customer Stripe token created',
               render: @user.as_json(:only => [:id, :card_last4, :card_exp_month, :card_exp_year, :card_type])
             }.to_json, status: 200

     else
     render json: {
               status: 400,
               message: 'Creating the Customer Stripe Token failed'
             }.to_json, status: 400

   end
   end

   def destroy
     customer = Stripe::Customer.retrieve(current_customer.stripe_id)
     customer.subscriptions.retrieve(current_customer.stripe_subscription_id).delete
     current_customer.update(stripe_subscription_id: nil)

     redirect_to root_path, notice: "Your subscription has been canceled."
   end

   private

   def user_params
     params.permit(:id, :first_name, :last_name, :email, :is_active, :is_admin, :date, :user_type, :phone, :about_me, :image, :password, :password_confirmation, :address, :address1, :address2, :city, :country, :zipcode, :stripe_id, :card_last4, :card_exp_month, :card_exp_year, :card_type)
   end

 end
