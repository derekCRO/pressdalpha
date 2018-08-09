class Users::SessionsController < Devise::SessionsController
   before_action :set_route

   private

   def set_route
      @route = request.path.split('/')[0]
   end

	module Users
	  class SessionsController < Devise::SessionsController
	   def new
		self.resource = resource_class.new(sign_in_params)
		store_location_for(resource, params[:redirect_to])
		super
	   end
	  end
	end
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
