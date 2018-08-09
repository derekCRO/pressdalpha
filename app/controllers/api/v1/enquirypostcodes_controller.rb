class Api::V1::EnquirypostcodesController < Api::V1::ApplicationController
	skip_before_action :authenticate_user!, raise: false
	respond_to :json

  def create
    enquirypostcode = Enquirypostcode.new(:first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email], :postcode => params[:postcode], :service_type => params[:service_type], :inform_me => params[:inform_me])

    if enquirypostcode.save

      render :json => enquirypostcode , :enquirypostcode => 201

      return

    else

      warden.custom_failure!

      render :json => { :success => false, :errorcode => 406, :message => "Paramaters incorrect - enquiry failed" }, :status => 406

    end
  end

		protected


  def enquirypostcode_params
    params.permit(:first_name, :last_name, :email, :postcode, :service_type, :inform_me)
  end

end
