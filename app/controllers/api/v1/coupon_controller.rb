class Api::V1::CouponController < Api::V1::ApplicationController
	before_action :authenticate_user!
	before_action :ensure_params_exist

	respond_to :json

	def couponing
		couponfind = Coupon.where(:code => params[:code]).first
		couponcheck = CouponReference.where(:code => params[:code]).where(:user_id => params[:user_id])


		if couponfind.nil?

			render json: {
								status: 400,
								message: 'Cannot find coupon',
							}.to_json, status: 400

		elsif couponcheck.exists?

			render json: {
								status: 400,
								message: 'Users has already used this coupon',
							}.to_json, status: 400

		elsif couponfind.coupon_type == 'fixed'
					@originalprice = params[:price].to_f
					@couponamount = couponfind.amount
					@newprice = @originalprice -= @couponamount

					render json: {
							 	 status: 200,
							 	 message: 'This is the new discounted price',
							   new_price: @newprice,
								 coupon: couponfind.as_json(:only => [:id, :coupon_type])
								}.to_json, status: 200

		elsif couponfind.coupon_type == 'percentage'
					@originalprice = params[:price].to_f
					@couponamount = couponfind.amount
					@newprice = @originalprice / @couponamount * 100.0

					render json: {
							 	 status: 200,
							 	 message: 'This is the new discounted price',
							   new_price: @newprice,
								 coupon: couponfind.as_json(:only => [:id, :coupon_type])
								}.to_json, status: 200

		elsif couponfind.coupon_type == 'referral'
				@originalprice = params[:price].to_f
				@couponamount = 10
				@newprice = @originalprice -= @couponamount

				render json: {
							 status: 200,
							 message: 'This is the new discounted price',
							 new_price: @newprice,
							 coupon: couponfind.as_json(:only => [:id, :coupon_type])
							}.to_json, status: 200
		end
	end

		protected

    def ensure_params_exist
      return unless params[:code].blank?
			render json: {
								status: 406,
								message: 'The code parameter is missing'
							}.to_json, status: 406
    end

    def coupon_params
        params.permit(:code, :coupon_type, :originator, :expires)
    end

end
