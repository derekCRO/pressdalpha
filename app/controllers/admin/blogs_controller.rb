class Admin::BlogsController < Admin::BaseAdminController
  before_action :set_content, only: [:show, :edit, :update, :destroy]

  # GET /contents
  # GET /contents.json
  def index
    @blogs = Blog.all
  end

  # GET /contents/1
  # GET /contents/1.json
  def show
  end

  # GET /contents/new
  def new
    @blog = Blog.new
    @blog_categories = BlogCategory.where(is_active: true)
    @blog_options = @blog_categories.map{|v| [v.id, v.name] }
  end

  # GET /contents/1/edit
  def edit
  	@blog_categories = BlogCategory.where(is_active: true)
  end

  # POST /contents
  # POST /contents.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to '/admin/blogs/', notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1
  # PATCH/PUT /contents/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to '/admin/blogs/', notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to '/admin/blogs/', notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :description, :image, :is_active, :tags, :author, :blog_category_id)
    end
end
