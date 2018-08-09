class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  def filter_by_postcode
    @postcode = params[:postcode]

    # fetch company ids based on postcode
    company_ids = CompaniesPostcode.joins(:postcode).where("postcodes.name = ?", @postcode).pluck(:company_id)

    selected_categories = CompanySelectedCategory.joins(:category).\
    where("company_id in (?)", company_ids).select("categories.id, categories.name, categories.image_file_name")

    # total partners for each caetegory
    # categories_count = CompanySelectedCategory.joins(:category).\
    # where("company_id in (?)", company_ids).select("categories.id as category_id, count(categories.id)")\
    # .group('categories.id')

    # return category information
    return selected_categories
  end
  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  def step1
    @ip = request.remote_ip
    puts @ip
    @zip = params[:zip_code]
    puts @zip
    @latitude= Geocoder.coordinates(@zip)
    puts @latitude

  end

  def step2
     @categories = Category.where(category_id: 0).order("id DESC")
  end

  def step3
     @id = params[:id]
     @subcategories = Category.where(category_id: @id)

     @subcategories.each do |subcat|
      #puts subcat.id
      @subcatquestions = CategoryAttribute.where(category_id: subcat.id)
     end

  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.build_user
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @getUser = User.where(:email => company_params[:email]).first

    respond_to do |format|
     if @getUser
      format.html {
      	flash[:notice] = "Email address already exist."
      	render :new
      }
      format.json { render :json => @company.errors, status => "error", message => "Email address already exist." }
     else
      #@user = User.new( :user_type => 'Partner', :is_active => 1, :first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation] )
      #if @user.save
        #@company = Company.new(:user_id => @user.id, :company_name => params[:company_name], :about_company => params[:about_company], :location => params[:location], :is_active => params[:is_active], :logo => params[:logo])
        if @company.save
          format.html { redirect_to '/admin/companies/', notice: 'Company was successfully created.' }
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
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to '/admin/companies/', notice: 'Company was successfully updated.' }
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
      format.html { redirect_to '/admin/companies/', notice: 'Company was successfully destroyed.' }
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
      params.require(:company).permit(:is_active, :company_name, :about_company, :location, :logo, :service, :image, :zipcode, :is_publish, :latitude, :longitude, :user_attributes => [:first_name, :last_name, :email, :password, :password_confirmation, :user_type])
    end
end
