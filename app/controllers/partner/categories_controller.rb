class Partner::CategoriesController < Partner::BasePartnerController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index

    @categories = Category.where(category_id: '0').order("id DESC")
    @category = Category.new
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
  end

  def selected_category
    @company = Company.where(user_id: current_partner.id).first
    @company_id = @company.id
    @categories = CompanySelectedCategory.where(company_id: @company_id, parent_id: 0)


  end

  # POST /categories
  # POST /categories.json
  def create
      @selected_cats = params[:select_category]

      @subcats = Category.where(category_id: @selected_cats)

       @subcats.each do |subcat|

         #@name = subcat.name
         #puts @name
         #@is_active = subcat.is_active
         #@category_id = subcat.category_id

          @selectedcat=CompanySelectedCategory.new(:category=>subcat.category_id, :name=>subcat.name, :is_active=>subcat.is_active)
          if @selectedcat.save

          end
       end


  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to '/admin/categories/', notice: 'Category was successfully updated.' }
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
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :category_id, :image, :image_url, :is_active)
    end
end
