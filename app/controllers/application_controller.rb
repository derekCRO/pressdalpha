class ApplicationController < ActionController::Base
  before_action :recent_blogs

  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      'admin_logsign'
    elsif devise_controller? && resource_name == :partner
      'partner_logsign'
    elsif devise_controller? && resource_name == :staff
      'staff_logsign'
    else
      'application'
    end
  end

  private

  # Overwriting the sign_out redirect path method

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
      new_customer_session_path
    elsif resource_or_scope == :partner
      new_partner_session_path
    elsif resource_or_scope == :user
      users_index_path
    elsif resource_or_scope == :staff
      users_index_path
    elsif resource_or_scope == :admin
      new_admin_session_path
    end
  end

  def after_sign_in_path_for(resource)
    Rails.logger.debug("Resource1: #{session[:customer_return_to]}")
    if resource == :admin
      users_dashboard_path(resource)
    elsif resource.class == Partner
      '/partner/users/dashboard' # users_dashboard_path(partner)
    elsif resource.class == Staff
      '/staff/users/dashboard' # users_dashboard_path(staff)
    elsif resource.class == Customer
      # '/customer/my_account'
      sign_in_url = new_user_session_url
      root_path = '/customer/my_account'
      # if request.referer == sign_in_url
      #  Rails.logger.debug(root_path)
      #  root_path
      # else
      #  stored_location_for(resource) || request.referer || root_path
      # end

      if session[:customer_return_to]
        session[:customer_return_to]
      else
        root_path
      end
    end
  end

  # Overwriting the sign_in redirect path method
  # def after_sign_in_path_for(resource)
  #  if resource == :admin
  #    users_dashboard_path
  #  elsif resource.user_type == :partner
  #    partner_users_path
  #  elsif resource_or_scope == :customer
  #    customer_my_account_path
  #  elsif resource_or_scope == :user
  #    customer_my_account_path
  #  end
  # end

  def after_sign_up_path_for(resource_or_scope)
    if resource_or_scope == :customer
      customer_my_account_path
    elsif resource_or_scope == :user
      customer_my_account_path
    end
  end

  def original_url
    base_url + original_fullpath
  end

  private

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:customer, request.fullpath)
  end

  private

  def recent_blogs
    @recent_blogs = Blog.order(created_at: :desc).limit(5)
  end
  end
