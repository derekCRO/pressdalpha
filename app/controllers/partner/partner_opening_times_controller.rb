class Partner::PartnerOpeningTimesController < Partner::BasePartnerController
  before_action :set_opening_time, only: [:show, :edit, :update, :destroy]

  def index
    @partner_opening_times = PartnerOpeningTime.where(start: params[:start]..params[:end])
  end

  def show
  end

  def new
    @partner_opening_time = PartnerOpeningTime.new
  end

  def edit
  end

  def create
    @partner_opening_time = PartnerOpeningTime.new(partneropeningtime_params)
    @partner_opening_time.save
  end

  def update
    @partner_opening_time.update(event_params)
  end

  def destroy
    @partner_opening_time.destroy
  end

  private
    def set_opening_time
      @partner_opening_time = PartnerOpeningTime.find(params[:id])
    end

    def partner_opening_time_params
      params.require(:partner_opening_time).permit(:title, :date_range, :start, :end, :color)
    end
end
