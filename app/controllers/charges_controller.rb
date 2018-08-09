class ChargesController < ApplicationController
  before_action :authenticate_customer!, except: [:new]
  before_action :redirect_to_signup, only: [:new]

   def show
   end

   def new
   end

   def create
     customer = if current_customer.stripe_id?
                  Stripe::Customer.retrieve(current_customer.stripe_id)
                else
                  Stripe::Customer.create(email: current_customer.email)
                end

     options = {
       stripe_id: customer.id,
     }

     # Only update the card on file if we're adding a new one
     options.merge!(
       card_last4: params[:card_last4],
       card_exp_month: params[:card_exp_month],
       card_exp_year: params[:card_exp_year],
       card_type: params[:card_brand]
     ) if params[:card_last4]

     current_customer.update(options)

     redirect_to root_path
   end

   def destroy
     customer = Stripe::Customer.retrieve(current_customer.stripe_id)
     customer.subscriptions.retrieve(current_customer.stripe_subscription_id).delete
     current_customer.update(stripe_subscription_id: nil)

     redirect_to root_path, notice: "Your subscription has been canceled."
   end

   private

     def redirect_to_signup
       if !customer_signed_in?
         session["customer_return_to"] = new_charge_path
         redirect_to new_customer_registration_path
       end
     end
 end
