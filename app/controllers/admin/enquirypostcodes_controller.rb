class Admin::EnquirypostcodesController < Admin::BaseAdminController

  def index
    @enquirypostcodes= Enquirypostcode.all
  end

  def show
  end

end
