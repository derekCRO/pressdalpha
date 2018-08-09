class Admin::SiteSettingsController < Admin::BaseAdminController
  before_action :set_site_setting, only: [:show, :edit, :update, :destroy]

  # GET /site_settings
  # GET /site_settings.json
  def index
    @site_setting = SiteSetting.first
  end

  # GET /site_settings/1
  # GET /site_settings/1.json
  def show
  end

  # GET /site_settings/new
  def new
    @site_setting = SiteSetting.new
  end

  # GET /site_settings/1/edit
  def edit
    @site_setting = SiteSetting.first
  end

  # POST /site_settings
  # POST /site_settings.json
  def create
    @site_setting = SiteSetting.new(site_setting_params)

    respond_to do |format|
      if @site_setting.save
        format.html { redirect_to @site_setting, notice: 'Site setting was successfully created.' }
        format.json { render :show, status: :created, location: @site_setting }
      else
        format.html { render :new }
        format.json { render json: @site_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_settings/1
  # PATCH/PUT /site_settings/1.json
  def update
    respond_to do |format|
      if @site_setting.update(site_setting_params)
        #format.html { redirect_to @site_setting, notice: 'Site setting was successfully updated.' }
        format.html { redirect_to '/admin/site_settings/1/edit', notice: 'Site setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @site_setting }
      else
        format.html { render :edit }
        format.json { render json: @site_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_settings/1
  # DELETE /site_settings/1.json
  def destroy
    @site_setting.destroy
    respond_to do |format|
      format.html { redirect_to site_settings_url, notice: 'Site setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_setting
      @site_setting = SiteSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_setting_params
     # params.fetch(:site_setting, {})
       params.require(:site_setting).permit(:facebook_link, :site_email, :phone_no, :google_plus_link, :radius)

    end
end
