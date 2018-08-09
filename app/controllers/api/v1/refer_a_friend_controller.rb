class Api::V1::ReferAFriendController < Api::V1::ApplicationController
	before_action :authenticate_user!
	before_action :ensure_params_exist

	respond_to :json

	def findcoupon
		couponfind = Coupon.where(:originator => params[:user_id]).where(:coupon_type => 'referral').first
		if couponfind.nil?

			render json: {
								status: 400,
								message: 'Cannot find a referall code  - please create one',
							}.to_json, status: 400
		else
			render json: {
					 	 status: 200,
					 	 message: 'Here is your referral code',
					   render: couponfind.as_json(:only => [:code, :coupon_type])
						}.to_json, status: 200

		end
	end

	def create
		@user = User.find_by(:id => params[:user_id])
		@string = @user.first_name
    @codegenerator = @string + SecureRandom.hex(5)
		@coupon = Coupon.new(:code => @codegenerator, :coupon_type => 'referral', :originator => params[:user_id])

      if @coupon.save

				render json: {
							 status: 200,
							 message: 'Referral code created - here is your code',
							 render: @coupon.as_json(:only => [:code, :coupon_type])
							}.to_json, status: 200

      else

				render json: {
									status: 400,
									message: 'Failed to create referral code - either parameters are missing or a code already exists',
								}.to_json, status: 400

      end
    end


		protected

    def ensure_params_exist
      return unless params[:user_id].blank?
			render json: {
								status: 406,
								message: 'The user_id parameter is missing'
							}.to_json, status: 406
    end

    def coupon_params
        params.permit(:code, :coupon_type, :originator, :expires)
    end

end
