class Admin::CompaniesController < Admin::BaseAdminController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  def company_ratings
    @companies = Company.all
  end

  def promo_materials_on
  @company = Company.find(params[:id])
  @company.update_attributes(:using_promo_material => 'true')
  if @company.update(company_params)
    respond_to do |format|
      format.html { redirect_to admin_company_ratings_path
        flash[:success] = 'Promo Materials is now True'
      }
    format.js
    format.json { render :show, status: :ok, location: @company }
    end
  end
  end

  def promo_materials_off
  @company = Company.find(params[:id])
  @company.update_attributes(:using_promo_material => 'false')
  if @company.update(company_params)
    respond_to do |format|
      format.html { redirect_to admin_company_ratings_path
        flash[:success] = 'Promo Materials is now False'
      }
    format.js
    format.json { render :show, status: :ok, location: @company }
    end
  end
  end

  def preferred_partner_on
  @company = Company.find(params[:id])
  @company.update_attributes(:preferred_partner => 'true')
  if @company.update(company_params)
    respond_to do |format|
      format.html { redirect_to admin_company_ratings_path
        flash[:success] = 'Promo Materials is now True'
      }
    format.js
    format.json { render :show, status: :ok, location: @company }
    end
  end
  end

  def preferred_partner_off
  @company = Company.find(params[:id])
  @company.update_attributes(:preferred_partner => 'false')
  if @company.update(company_params)
    respond_to do |format|
      format.html { redirect_to admin_company_ratings_path
        flash[:success] = 'Promo Materials is now False'
      }
    format.js
    format.json { render :show, status: :ok, location: @company }
    end
  end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.build_partner
    respond_to do |format|
  format.html
  format.js
end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @getUser = User.where(:email => company_params[:email]).first

    respond_to do |format|
     if @getUser
      format.html {
      	flash[:error] = "Email address already exist."
      	render :new
      }
      format.json { render :json => @company.errors, status => "error", message => "Email address already exist." }
     else
      #@user = User.new( :user_type => 'Partner', :is_active => 1, :first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation] )
      #if @user.save
        #@company = Company.new(:user_id => @user.id, :company_name => params[:company_name], :about_company => params[:about_company], :location => params[:location], :is_active => params[:is_active], :logo => params[:logo])
        if @company.save
          format.html {
            redirect_to '/admin/companies/'
            flash[:success] = "Company was successfully created."
          }
          format.json { render :show, status: :created, location: @company }
        else
        	format.html { render :new }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      #else
        #format.html { render :new }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      #end
     end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    params[:company][:postcode_ids] ||=[]
    respond_to do |format|
      if @company.update(company_params)
        format.html {
          redirect_to '/admin/companies/'
          flash[:success] = "Company was successfully updated."
        }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to '/admin/companies/', flash[:warning] = "Company was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.permit(:company, :is_active, :company_name, :about_company, :location, :logo, :service, :image, :zipcode, :is_publish, :latitude, :longitude, :partner_attributes => [:first_name, :last_name, :email, :password, :password_confirmation, :user_type], :postcode_attributes => [:name])
    end
end
