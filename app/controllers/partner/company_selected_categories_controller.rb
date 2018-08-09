class Partner::CompanySelectedCategoriesController < Partner::BasePartnerController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @company = Company.where(user_id: current_partner.id).first
    @company_id = @company.id
    @selected_category = CompanySelectedCategory.select("category_id").where(company_id: @company_id, parent_id: 0)
    @categories = Category.where.not(id: @selected_category).order("id DESC")
    @category = Category.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def sub
    #@categories = Category.all
    @categories = Category.where(category_id: params[:id]).order("name DESC")
    @category = Category.find(params[:id])
  end

  def subedit
    @category = Category.find(params[:id])
    @categorycomp = CompanySelectedCategory.where(category_id: params[:id], company_id: params[:company_id]).first
    @parent = Category.find(params[:cid])
    @catattributes = CompanySelectedCategoryAttribute.where(category_id: @category, company_id: params[:company_id])
  end


  def subupdate
    @category = Category.find(params[:id])
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_sub_category_url(id: params[:cid]), notice: 'Options were successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_category_attribute
    @categoryatt = CompanySelectedCategory.where(id: params[:id], company_id: params[:company_id])
    respond_to do |format|
      if @categoryatt.update(company_selected_category_params)
        format.html { redirect_to '/partner/company_selected_categories/selected_category/', notice: 'Category question were successfully updated.' }
        format.json { render :show, status: :ok, location: @categoryatt}
      else
        format.html { render :edit }
        format.json { render json: @categoryatt.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def manage_option
  	@categories = Category.where(category_id: @id).order("id DESC")
  end

  def selected_category
    @company = Company.where(user_id: current_partner.id).first
    @company_id = @company.id
    @categories = CompanySelectedCategory.where(company_id: @company_id)
  end

  # POST /categories
  # POST /categories.json
  def create
	  respond_to do |format|
	    @company = Company.where(user_id: current_partner.id).first
	    @company_id = @company.id
	    @selected_cats = params[:select_category]
	    #puts @selected_cats
	    @selected_cats.each do |selected_cat|
		 @parentcategory = Category.where(id: selected_cat).first
		 @selectedparentcat=CompanySelectedCategory.new(:category_id=>@parentcategory.id, :service_type=>'Direct', :parent_id=>@parentcategory.category_id, :name=>@parentcategory.name, :company_id=>@company_id, :is_active=>@parentcategory.is_active, :price_per_hour=>@parentcategory.price_per_hour)
		 @selectedparentcat.save

		 @subcats = Category.where(category_id: selected_cat)
		 @subcats.each do |subcat|
		   @selectedcat=CompanySelectedCategory.new(:category_id=>subcat.id, :parent_id=>subcat.category_id, :name=>subcat.name, :company_id=>@company_id, :is_active=>subcat.is_active, :price_per_hour=>subcat.price_per_hour)
		   @selectedcat.save
		   @last_company_selected_category_id = CompanySelectedCategory.last.id
		   @subcatattributes = CategoryAttribute.where(category_id: subcat.id)
		   @subcatattributes.each do |subcatattribute|
		     #puts subcatattribute.name
		     @selectedcatattribute=CompanySelectedCategoryAttribute.new(:name=>subcatattribute.name, :field_type=>subcatattribute.field_type, :price_per_hour=>@parentcategory.price_per_hour, :company_selected_category_parent_id=>subcat.category_id, :hour_per_item=>subcatattribute.hour_per_item, :required=>subcatattribute.required, :category_id=>subcatattribute.category_id, :category_attribute_id=>subcatattribute.id, :material_cost=>subcatattribute.material_cost, :company_id=>@company_id)
		     @selectedcat.companycatatt << @selectedcatattribute
		     @selectedcat.valid?
		   end
		   @selectedcat.save
		     #puts @selectedcat.errors.full_messages


		 end
	    end
      format.html { redirect_to partner_company_selected_categories_selected_category_path
        flash[:success] = 'Categories has been updated.'
      }
	    format.json { render :show, status: :ok, location: @@selectedcat }
	  end

  end


  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(company_selected_category_params)
        CompanySelectedCategoryAttribute.where(:company_selected_category_parent_id => company_selected_category_params[:category_id], :company_id => company_selected_category_params[:company_id]).update_all(price_per_hour: company_selected_category_params[:price_per_hour])
        format.html { redirect_to partner_company_selected_categories_selected_category_path
          flash[:success] = 'Category has been updated.'
        }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @id = params[:id]
    @catid = CompanySelectedCategory.where(id: @id).first
    @subcat_id = CompanySelectedCategory.where(parent_id: @catid.category_id)
    @subcatatt_id = CompanySelectedCategory.select("category_id").where(parent_id: @catid.category_id)
    puts @sucatatt_id
    @delete_subcatatt = CompanySelectedCategoryAttribute.where(:category_id => @subcatatt_id).destroy_all
    @delete_subcat = CompanySelectedCategory.where(:id => @subcat_id).destroy_all
    @category.destroy
    respond_to do |format|
      format.html { redirect_to partner_company_selected_categories_selected_category_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = CompanySelectedCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_selected_category_params
      params.require(:company_selected_category).permit(:id, :price_per_hour, :weekly_price_per_hour_3_months, :weekly_price_per_hour_6_months, :weekly_price_per_hour_12_months, :fortnightly_price_per_hour_3_months, :fortnightly_price_per_hour_6_months, :fortnightly_price_per_hour_12_months, :monthly_price_per_hour_3_months, :monthly_price_per_hour_6_months, :monthly_price_per_hour_12_months, :service_type, :category_id, :company_id, :companycatatt_attributes =>[:id, :name,:field_type,:hour_per_item,:required,:category_id,:material_cost,:is_company_support, :category_attribute_id, :company_selected_category_parent_id, :price_per_hour])
    end
end
