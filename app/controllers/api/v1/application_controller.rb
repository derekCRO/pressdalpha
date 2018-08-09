class Api::V1::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  before_action :authenticate_user!

  include ActionController::ImplicitRender
  include ActionController::MimeResponds

  protected

def json_request?
  request.format.json?
end

  private

end
