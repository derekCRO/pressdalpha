class Partner::ManualCustomersController < Partner::BasePartnerController
  before_action :set_manual_customer, only: [:show, :edit, :update, :destroy]
  # GET /manual_customers
  # GET /manual_customers.json

  def index
    @company = Company.where(user_id: current_partner.id).first
    @manual_customers = ManualCustomer.all
  end

  # GET /manual_customers/1
  # GET /manual_customers/1.json
  def show

  end

  # GET /manual_customers/new
  def new
    @manual_customer = ManualCustomer.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /manual_customers/1/edit
  def edit
	#@manual_customer.build_companylocation
  respond_to do |format|
    format.html
    format.js
  end
  end

  def details
     @manual_customer = ManualCustomer.find(params[:id])
     @jobs = Job.where(manual_customers_id: @manual_customer.id)
     respond_to do |format|
       format.html
       format.js
     end
  end

  # POST /manual_customers
  # POST /manual_customers.json
  def create
    @manual_customer = ManualCustomer.new(manual_customer_params)
    @manual_customer.partner = current_partner
    respond_to do |format|
      if @manual_customer.save
        format.html { redirect_to partner_manual_customers_path
          flash[:success] = 'Customer was successfully created.'
        }
        format.json { render :show, status: :created, location: @manual_customer }
      else
        format.html { render :new }
        format.json { render json: @manual_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manual_customers/1
  # PATCH/PUT /manual_customers/1.json
  def update
    respond_to do |format|
      if @manual_customer.update(manual_customer_params)
        format.html { redirect_to partner_manual_customers_path
          flash[:success] = 'Customer was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @manual_customer }
      else
        format.html { render :edit }
        format.json { render json: @manual_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manual_customers/1
  # DELETE /manual_customers/1.json
  def destroy
    @manual_customer.destroy
    respond_to do |format|
      format.html { redirect_to '/partner/manual_customers/', notice: 'ManualCustomer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /manual_customers/new
  def profile
    @manual_customer = ManualCustomer.find(current_partner.id)
    #@manual_customer = ManualCustomer.where(manual_customer_type: 'Partner',id: current_partner.id).first
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manual_customer
    	 if(params[:id])
        @manual_customer = ManualCustomer.find(params[:id])
      else
        @manual_customer = ManualCustomer.find(current_manual_customer.id)
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manual_customer_params
      params.require(:manual_customer).permit(:first_name, :last_name, :email, :phone, :address1, :address2, :city, :country, :zipcode, :latitude, :longitude, :partner_id, :notes)
    end
end
