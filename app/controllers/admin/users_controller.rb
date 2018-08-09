class Admin::UsersController < Admin::BaseAdminController

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
    @overallratings = CompanyRating.sum(:score) / CompanyRating.count
  end

  def viewcustomer
    @user = User.find(params[:id])
    @totaljobs = Job.where(user_id: @user.id).count
    @totaljobsrevenue = Job.where(user_id: @user.id).sum(:price)
    @totalsubscriptions = Subscription.where(user_id: @user.id).count
    @jobs = Job.where(user_id: @user.id)
    @subscriptions = Subscription.where(user_id: @user.id)
  end

  def login
  end

  # GET /users/new
  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /users/1/edit
  def edit
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
        format.html { redirect_to '/admin/users/', notice: 'User was successfully created.' }
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
        format.html { redirect_to '/admin/users/', notice: 'User was successfully updated.' }
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
      format.html { redirect_to '/admin/users/', notice: 'User was successfully destroyed.' }
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

    def customer
      #@users = User.all
      @users = User.where(user_type: 'Customer').order("id DESC")
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :first_name, :last_name, :email, :password, :password_confirmation, :phone, :address, :image)
    end
end
