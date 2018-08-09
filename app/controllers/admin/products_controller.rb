require 'httparty'
require 'kitco'
class Admin::ProductsController < Admin::BaseAdminController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  #require '/home/greenacy/greenacy/vendor/kitco/lib/kitco.rb'


  #puts Kitco.silver
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @pt = Kitco.platinum
    @pd = Kitco.palladium
    @rh = Kitco.rhodium
    @pt = JSON.parse(@pt)
    @pd = JSON.parse(@pd)
    rescue JSON::ParserError, TypeError => e
      puts e

  end

  # GET /products/new
  def new
    @product = Product.new
    #@categories = Category.all
    @categories = Category.where(:company_id => '0')
  end

  # GET /products/1/edit
  def edit
    #@categories = Category.all
    @categories = Category.where(:company_id => '0')
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_products_url, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_products_url, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :serial, :weight, :pt_weight, :pd_weight, :rh_weight, :stainless, :moisture, :category_id, :category, :make, :model, :image_url, :image, :value_troy_pt, :value_troy_pd, :value_troy_rh, :stainless_steel, :is_active)
    end
end
