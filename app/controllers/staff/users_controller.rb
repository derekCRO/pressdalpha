class Staff::UsersController < Staff::BaseStaffController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_company, only: [:dashboard]
  # GET /users
  # GET /users.json
  def index
    #@users = User.all
    @users = User.where(user_type: 'Customer').order("id DESC")
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def dashboard
    @jobstoday = Job.pending_jobs(@company.id).limit(5)
    #@jobstoday = Job.assigned_jobs(@company.id).where(booking_date: Date.today.all_day)
  end


  def profile
    @user = User.find(current_staff.id)
    #@user = User.where(user_type: 'Partner',id: current_partner.id).first
    respond_to do |format|
      format.html
      format.js
    end
  end

  def profileupdate
    Rails.logger.debug("Resource: #{@user}")
    @user = User.find(current_staff.id)
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to staff_staff_dashboard_path
          flash[:success] = 'Profile was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def login
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/staff/users/', notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to '/staff/users/', notice: 'User was successfully updated.' }
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
      format.html { redirect_to '/staff/users/', notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def partner
    #@users = User.all
    @users = User.where(user_type: 'Partner').order("id DESC")
  end

  def staff
    #@users = User.all
    @users = User.where(user_type: 'Staff').order("id DESC")
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
      @company = current_staff.company
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:staff).permit(:id, :first_name, :last_name, :email, :password, :password_confirmation, :phone, :address, :image)
    end
end
