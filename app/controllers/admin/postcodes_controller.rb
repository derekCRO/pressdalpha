class Admin::PostcodesController < Admin::BaseAdminController
  before_action :set_content, only: [:show, :edit, :update, :destroy]

  # GET /contents
  # GET /contents.json
  def index
    @postcodes = Postcode.all
  end

  # GET /contents/1
  # GET /contents/1.json
  def show
  end

  # GET /contents/new
  def new
    @postcode = Postcode.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /contents/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /contents
  # POST /contents.json
  def create
    @postcode = Postcode.new(postcode_params)

    respond_to do |format|
      if @postcode.save
        format.html { redirect_to '/admin/postcodes/', notice: 'Postcode was successfully created.' }
        format.json { render :show, status: :created, location: @postcode }
      else
        format.html { render :new }
        format.json { render json: @postcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1
  # PATCH/PUT /contents/1.json
  def update
    respond_to do |format|
      if @postcode.update(postcode_params)
        format.html { redirect_to '/admin/postcodes/', notice: 'Postcode was successfully updated.' }
        format.json { render :show, status: :ok, location: @postcode }
      else
        format.html { render :edit }
        format.json { render json: @postcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.json
  def destroy
    @postcode.destroy
    respond_to do |format|
      format.html { redirect_to '/admin/postcodes/', notice: 'Postcode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @postcode = Postcode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def postcode_params
      params.require(:postcode).permit(:name)
    end
end
