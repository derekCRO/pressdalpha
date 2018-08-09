class Partner::PackagedetailsController < Partner::BasePartnerController
before_action :set_company, only: [:index, :update_partner_package, :update]

  def index
    @packagedetails = Packagedetail.all
    @company = current_partner.company
    @companypackage = current_partner.company.selected_package
  end

  def update_partner_package
    @packagedetail = Packagedetail.find(params[:id])
    @company = current_partner.company
    @company.update_attributes(selected_package: params[:selected_package])
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to partner_packagedetails_path, notice: 'Package Succesfully Updated.' }
        format.json { render status: :created, location: @packagedetail }
        format.js { redirect_to partner_packagedetails_path, notice: 'Package Succesfully Updated.' }
      else
        format.html { render :new }
        format.json { render json: @packagedetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @packagedetail = Packagedetail.new
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
    @packagedetail= Packagedetail.new(packagedetail_params)
    respond_to do |format|
      if @packagedetail.save
        format.html { redirect_to partner_packagedetail_path, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @packagedetail }
        format.js { redirect_to partner_packagedetail_path, notice: 'Job was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @packagedetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @packagedetail.update(packagedetail_params)
        format.html { redirect_to @packagedetail, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @packagedetail }
      else
        format.html { render :edit }
        format.json { render json: @packagedetail.errors, status: :unprocessable_entity }
      end
    end
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @packagedetail, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @packagedetail }
      else
        format.html { render :edit }
        format.json { render json: @packagedetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @packagedetail.destroy
    respond_to do |format|
      format.html { redirect_to partner_packagedetail_path, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

def set_company
  @company = current_partner.company
end

  # Never trust parameters from the scary internet, only allow the white list through.
  def packagedetail_params
    params.require(:packagedetail).permit(:id, :package_name, :order_limit, :postcode_limit, :user_limit, :manual_bookings, :advanced_reports, :api_access, :monthly_cost, :created_at, :updated_at)
  end

  def company_params
    params.permit(:selected_package)
  end

end
