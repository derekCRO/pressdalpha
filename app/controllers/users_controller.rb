class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy myaccount]
  before_action :authenticate_customer!, except: [:index]
  before_action :set_user_type
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  def list
    if current_customer
      @user = User.find(current_customer.id)
    else
      redirect_to action: 'index', alert: 'Sorry you donot have permission to access.'
    end
    @tasks = Job.where(user_id: current_customer.id)
  end

  def transaction
    if current_customer
      @user = User.find(current_customer.id)
    else
      redirect_to action: 'index', alert: 'Sorry you donot have permission to access.'
     end
    @task = Transaction.where(customer_id: current_customer.id)
  end

  def step55
    @task = Task.find(params[:id])
    @id = params[:cid]
    @category = Category.find(params[:cid])
    @subcategories = Category.where(category_id: @id)
    @compQuotations = CompanySelectedCategory.where(category_id: params[:cid], service_type: 'Quotation')
    @compDirect = CompanySelectedCategory.where.not(service_type: 'Quotation').where(category_id: params[:cid])
    @company = Company.where(is_active: true)
  end

  # GET /customers/task_details
  def task_details
    @task = Job.find(params[:id])
    @id = params[:cid]
    @category = Category.find(@task.category_id)
    @subcategories = Category.where(category_id: @task.category_id)
    @text = @task.task.propertytext
    if current_customer
      @user = User.find(current_customer.id)
    else
      redirect_to action: 'index', alert: 'Sorry you donot have permission to access.'
    end
  end

  # GET /users/my_account
  def my_account
    if current_customer
      @user = User.find(current_customer.id)
    else
      redirect_to action: 'index', alert: 'Sorry you donot have permission to access.'
    end
  end

  def updateaccount
    @customer = User.find(current_customer.id)
    respond_to do |format|
      if @customer.update(user_params)
        format.html { redirect_to users_myaccount_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :my_account }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
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
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def job_detail
    @task = Job.find(params[:id])
  end

  private

  def set_user_type
    @user_type = user_type
   end

  def user_type
    User.user_types.include?(params[:type]) ? params[:type] : 'Customer'
   end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = if params[:id]
              User.find(params[:id])
            else
              User.find(current_user.id)
           end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(user_type.underscore.to_sym).permit(:first_name, :last_name, :email, :is_active, :is_admin, :date, :user_type, :phone, :about_me, :image, :password, :password_confirmation, :address, :address1, :address2, :city, :country, :zipcode)
  end
end
