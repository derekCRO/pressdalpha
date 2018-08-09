class Charge < ActiveRecord::Base



  attr_accessor :payment_token

  def save_and_make_payment
    if valid?
      begin
        charge = Stripe::Charge.create(
          amount: price_in_cents,
          currency: currency,
          source: payment_token,
        )
        save
      rescue Stripe::CardError => e
        errors.add :credit_card, e.message
        false
      end
    end
  end

  private


end
