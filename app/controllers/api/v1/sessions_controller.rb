class Api::V1::SessionsController < Devise::SessionsController
	prepend_before_action :require_no_authentication, :only => [:create, :forget_password]
	before_action :ensure_params_exist, :only => [:create]

	respond_to :json

	def create
		user = User.find_by(:email => params[:user_login])
		unless user.nil?
			if user.valid_password? params[:password]
				render :json => user
				return
			end
		end
		render :json => { :success => false, :errorcode => 401, :message => "Incorrect e-mail or password" }, :status => 401
	end

	def update_password
	  user = User.find_by(:id => params[:user_id])
		if !params[:password].present?
	    render json: {error: 'Password not present'}, status: :unprocessable_entity
	    return
	  end

	  if user.reset_password!(params[:password])
	    render json: {status: 'ok'}, status: :ok
	  else
	    render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
	  end
	end

	def forget_password
		begin
		  if params[:user_login].present?
				## Find user with email
			  @user = User.find_by(email: params[:user_login])
		    if (@user.present?)
					@user.send_reset_password_instructions
					 render json:{
						 data:{
							 messages:"You will receive an email with instructions about how to reset your password in a few minutes."
						},
						rstatus:1,
						status: 200
					}
		    else
		      render json:{
						data:{
							messages: "No user found with email #{params[:user_login]}"
						},
						rstatus:0,
						status: 404
					}
		    end
		  else
		    render json:{
					data:{
						messages: "Email Address is required"
					},
					rstatus:0,
					status: 404
				}
		  end
		rescue Exception => e
			render json: {
				data:{
					messages: e.message
				},
				rstatus:0,
				status: 404
			}
		end
	end

	def destroy
		warden.custom_failure!
    render :json => { :success => true, :code => 200, :message => "User signed out" }, :status => 200
  end

		protected
	def ensure_params_exist
		return unless params[:user_login].blank?
		render :json => { :success => false, :errorcode => 422, :message => "missing user_login parameter" }, :status => 422
	end

		def invalid_login_attempt
			warden.custom_failure!
			render :json => { :success => false, :errorcode => 401, :message => "Error with your login or password" }, :status => 401
		end
end
