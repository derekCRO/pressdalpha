class Coupon < ActiveRecord::Base
validates_uniqueness_of :originator, if: :referral?

def referral?
  coupon_type == "referral"
end

  private

end
