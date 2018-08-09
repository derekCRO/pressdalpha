class Partner::SubscriptionsController < Partner::BasePartnerController

  # GET /jobs
  # GET /jobs.json
  def index
    @company = Company.where(user_id: current_partner.id).first
    @subscriptions = Subscription.where(company_id: @company.id)
  end

  def list
    @company = Company.where(user_id: current_partner.id).first
    @subscriptions = Subscription.where(company_id: @company.id)
  end



  # GET /customers/task_details
  def details
     @subscription = Subscription.find(params[:id])
     respond_to do |format|
       format.html
       format.js
     end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @subscription = Subscription.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /jobs/new
  def new
    @subscription = Subscription.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @subscription = Subscription.new(subscription_params)
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to partner_subscription_list_manual_path, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @subscription }
        format.js { redirect_to partner_subscription_list_manual_path, notice: 'Subscription was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:recurring_type, :recurring_weeks_in_month, :recurring_months, :first_job_id, :date_of_first_booking, :recurring_price, :user_id, :partner_id, :company_id, :category_id, :created_at)
    end

end
