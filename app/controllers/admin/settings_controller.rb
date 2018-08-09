class Admin::SettingsController < Admin::BaseAdminController
  before_action :get_setting, only: [:edit, :update]

    def index
      @settings = Setting.get_all
    end

    def edit
      respond_to do |format|
        format.html
        format.js
      end
    end

    def update
      if @setting.value != params[:setting][:value]
        @setting.value = params[:setting][:value]
        @setting.save
        redirect_to admin_settings_path, notice: 'Setting has updated.'
      else
        redirect_to admin_settings_path
      end
    end

    def get_setting
      @setting = Setting.find_by(var: params[:id]) || Setting.new(var: params[:id])
    end
  end
