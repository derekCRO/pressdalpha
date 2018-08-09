class Partner::PagesController < Partner::BasePartnerController
  def show
    render template: "pages/#{params[:page]}"
  end
end
