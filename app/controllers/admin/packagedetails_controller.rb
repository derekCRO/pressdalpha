class Admin::PackagedetailsController < Admin::BaseAdminController

  def index
    @packagedetails = Packagedetail.all
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
    @packagedetail = Packagedetail.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @packagedetail = Packagedetail.new(packagedetail_params)
    respond_to do |format|
      if @packagedetail.save
        format.html { redirect_to admin_packagedetails_path, notice: 'Package was successfully created.' }
        format.json { render :show, status: :created, location: admin_packagedetail_path }
        format.js { redirect_to admin_packagedetails_path, notice: 'Package was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @packagedetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    @packagedetail = Packagedetail.find(params[:id])
    respond_to do |format|
      if @packagedetail.update(packagedetail_params)
        format.html { redirect_to admin_packagedetails_path
          flash[:success] = 'Package was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @packagedetail }
      else
        format.html { render :edit }
        format.json { render json: admin_packagedetails_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @packagedetail = Packagedetail.find(params[:id])
    @packagedetail.destroy
    respond_to do |format|
      format.html { redirect_to admin_packagedetails_path
        flash[:success] = 'Package was successfully deleted.'
      }
      format.json { head :no_content }
    end
  end

private

  # Never trust parameters from the scary internet, only allow the white list through.
  def packagedetail_params
    params.require(:packagedetail).permit(:id, :package_name, :order_limit, :postcode_limit, :user_limit, :manual_bookings, :advanced_reports, :api_access, :monthly_cost, :created_at, :updated_at)
  end

end
