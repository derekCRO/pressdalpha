# Using JWT from Ruby is straight forward. The below example expects you to have `jwt`
# in your Gemfile, you can read more about that gem at https://github.com/progrium/ruby-jwt.
# Assuming that you've set your shared secret and Zendesk subdomain in the environment, you
# can use Zendesk SSO from your controller like this example.


class Api::V1::ZendeskSessionController < Api::V1::ApplicationController
  skip_before_action :authenticate_user!, raise: false
  require 'securerandom' unless defined?(SecureRandom)

  # Configuration
  ZENDESK_SHARED_SECRET = ENV["ZENDESK_SHARED_SECRET"]
  ZENDESK_SUBDOMAIN     = ENV["ZENDESK_SUBDOMAIN"]

  def create
    user = User.find_by(:id => params[:user_id])
    if user.nil?
      render json: {
                status: 406,
                message: 'The user cant be found'
              }.to_json, status: 406
    else
      sign_into_zendesk(user)
    end
  end

  private

  def sign_into_zendesk(user)
    # This is the meat of the business, set up the parameters you wish
    # to forward to Zendesk. All parameters are documented in this page.
    iat = Time.now.to_i
    jti = "#{iat}/#{SecureRandom.hex(18)}"

    payload = JWT.encode({
      :iat   => iat, # Seconds since epoch, determine when this token is stale
      :jti   => jti, # Unique token id, helps prevent replay attacks
      :name  => user.fullname,
      :email => user.email,
    }, ZENDESK_SHARED_SECRET)

    render json: {
              jwt: payload
              }.to_json, status: 200
  end

  def zendesk_sso_url(payload)
    url = "https://#{ZENDESK_SUBDOMAIN}.zendesk.com/access/jwt?jwt=#{payload}"
    url += "&" + {return_to: params["return_to"]}.to_query if params["return_to"].present?
    url
  end
end
