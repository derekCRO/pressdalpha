class CustomAuthFailure < Devise::FailureApp
  def respond
    if request.format == :json
      self.status = 401
      self.content_type = 'json'
      self.response_body = '{"error" : "authentication error"}'
    else
      super
    end
  end
end
