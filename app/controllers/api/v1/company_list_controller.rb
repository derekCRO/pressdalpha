class Api::V1::CompanyListController < Api::V1::ApplicationController
  skip_before_action :authenticate_user!, raise: false
  respond_to :json

  def getcompanies
    if (params[:zipcode].present? && params[:properties].present? && params[:total_hours].present? && params[:start_date].present? && params[:end_date].present?)
      @companies_with_green, @companies_with_orange = Company.get_companies_data(params[:zipcode][0...4],params[:properties], params[:total_hours])
      start_date = Date.parse(params[:start_date]).wday+1
      end_date = Date.parse(params[:end_date]).wday+1
      wdays = [start_date,end_date].sort
      wday_range = Range.new(wdays[0], wdays[1])
      @green_company = @companies_with_green.includes(:time_slots).where(
                        {
                          time_slots:{
                            week_day_id: wday_range
                          }
                        }
                      ).order('companies.id ASC').as_json()
      @orange_company = @companies_with_orange.includes(:time_slots).where(
                        {
                          time_slots:{
                            week_day_id: wday_range
                          }
                        }
                      ).order('companies.id ASC').as_json()
      render json:{
        # green_companies: green_company,
        # orange_companies: orange_company,
        green_companies: @green_company.to_json(:only => [:id, :company_name, :location, :preferred_partner, :instant_book], :methods=> [:image_url_thumb, :average_rating]),
        orange_companies: @orange_company.to_json(:only => [:id, :company_name, :location, :preferred_partner, :instant_book], :methods=> [:image_url_thumb, :average_rating]),
        status: 200,
        messages: "OK"
      }
    else
      render json:{
        status: 404,
        messages: "Please provide all the following parameters 'zipcode, properties, start_date, end_date, total_hours', one of these is missing."
      }
    end
  end

protected


end
