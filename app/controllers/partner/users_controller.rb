class Partner::UsersController < Partner::BasePartnerController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @company = Company.where(user_id: current_partner.id)
    @users = User.where(user_type: 'Staff',company_id: @company).order("id DESC")

  end

  def customer_list
    @company = Company.where(user_id: current_partner.id).first
    @users = Job.where(company_id: @company.id).select(:user_id).distinct
    Rails.logger.debug("Resource: #{@users}")
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def dashboard
    @company = Company.where(user_id: current_partner.id)
  end

  def login
  end

  # GET /users/new
  def new
    @user = User.new
    @company = Company.where(user_id: current_partner.id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /users/1/edit
  def edit
	#@user.build_companylocation
  respond_to do |format|
    format.html
    format.js
  end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    user.skip_confirmation!
    respond_to do |format|
      if @user.save
        format.html { redirect_to partner_users_path
          flash[:success] = 'Staff Member was successfully created.'
        }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to partner_users_path
          flash[:danger] = 'Staff Member was not created.'
        }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to partner_users_path
          flash[:success] = 'Staff Member was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to '/partner/users/', notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /users/new
  def profile
    @user = User.find(current_partner.id)
    #@user = User.where(user_type: 'Partner',id: current_partner.id).first
    respond_to do |format|
      format.html
      format.js
    end
  end

  def profileupdate
    Rails.logger.debug("Resource: #{@user}")
    @user = User.find(current_partner.id)
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to partner_partner_dashboard_path
          flash[:success] = 'Profile was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
    	 if(params[:id])
        @user = User.find(params[:id])
      else
        @user = User.find(current_user.id)
      end

    end

    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:partner).permit(:partner, :first_name, :last_name, :email, :password, :password_confirmation, :phone, :address, :image, :user_type, :company_id, :auto_assign_staff, :companylocation_attributes => [:latitude, :longitude, :zipcode, :company_id, :id])
    end
end
