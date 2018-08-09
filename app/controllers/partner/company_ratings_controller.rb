class Partner::CompanyRatingsController < Partner::BasePartnerController

  def index
    @company_ratings= CompanyRatings.all
  end

  
end
