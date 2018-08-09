class Api::V1::AuthenticationController < Api::V1::ApplicationController
   skip_before_action :authenticate_user!, raise: false

	respond_to :json

  def create
      user = User.find_by(email: params[:email])
        if user && user.valid_password?(params[:password])
            render json: {
                      status: 200,
                      message: 'JWT Token Generated',
                      token: JsonWebToken.encode(sub: user.id),
                      user: user.as_json(:only => [ :id, :email, :first_name, :last_name, :zipcode ])
                    }.to_json, status: 200
      else
          render json: {
                    status: 400,
                    message: 'Invalid email or password',
                  }.to_json, status: 400
      end
  end

		protected


end
