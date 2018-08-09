class Admin::CategoriesController < Admin::BaseAdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  def sub
    #@categories = Category.all
    @categories = Category.where(category_id: params[:id]).order("name DESC")
    @category = Category.find(params[:id])
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def subnew
    @category = Category.find(params[:id])
    @questions = @category.questions.build
    @options = @questions.category_attribute_options.build
    @parent = Category.find(params[:id])
  end

  def subedit
    @category = Category.find(params[:id])
    @questions = @category.questions.build
    @options = @questions.category_attribute_options.build
    @parent = Category.find(params[:cid])
  end

  def subupdate
    @category = Category.find(params[:id])
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_sub_category_url(id: params[:cid]), notice: 'Options were successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { redirect_to admin_subedit_category_url(id: @category.id, cid: params[:cid]),flash: { :error => @category.errors.full_messages}}
        # format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def subcreate
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html {
        #redirect_to controller: 'categories', action: 'sub', id: params[:id], notice: 'Option was successfully created.'
        redirect_to admin_sub_category_url(id: params[:id]), notice: 'Options were successfully created.'
        }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { redirect_to admin_newsub_category_path(id: params[:id]),flash: { :error => @category.errors.full_messages}}
        # format.html { render :subnew }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /categories/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /categories
  # POST /categories.json
  def create

    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_url, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
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
        format.html { redirect_to '/admin/categories/', notice: 'Category update failed.' }
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
      params.require(:category).permit(:id, :name, :price_per_hour, :weekly_price_per_hour_3_months, :weekly_price_per_hour_6_months, :weekly_price_per_hour_12_months, :fortnightly_price_per_hour_3_months, :fortnightly_price_per_hour_6_months, :fortnightly_price_per_hour_12_months, :monthly_price_per_hour_3_months, :monthly_price_per_hour_6_months, :monthly_price_per_hour_12_months, :category_id, :image, :image_url, :mobile_cover_image ,:mobile_cover_image_url, :mobile_icon, :mobile_icon_url, :is_active, :questions_attributes => [:name, :group_name, :field_type, :hour_per_item, :material_cost, :information, :required, :category_id, :id, :category_attribute_options_attributes => [:options, :option_hours, :option_price, :category_attribute_id, :id, :_destroy]])
    end
end
