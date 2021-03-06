  class AdminUsersController < ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  # GET /admin_users
  # GET /admin_users.json
  def index
    # @admin_users = AdminUser.all
    @admin_users  = AdminUser.find_by_sql("select users.email, admin_users.* from users, admin_users where admin_users.user_id = users.id and users.is_admin=true")
  end

  # GET /admin_users/1
  # GET /admin_users/1.json
  def show
  end

  # GET /admin_users/new
  def new
    @admin_user = AdminUser.new
  end

  # GET /admin_users/1/edit
  def edit
  end

  # POST /admin_users
  # POST /admin_users.json
  def create
    # raise params.inspect
    @admin_user = AdminUser.new(admin_user_params)
    user = User.create({:email => params[:email], :password => params[:password], :password_confirmation => params[:password], :is_admin => true })
    @admin_user.user_id = user.id
    respond_to do |format|
      if @admin_user.save
        flash[:success] = 'Admin user was successfully created.'
        format.html { redirect_to @admin_user}
        format.json { render action: 'show', status: :created, location: @admin_user }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_users/1
  # PATCH/PUT /admin_users/1.json
  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to @admin_user, notice: 'Admin user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_users/1
  # DELETE /admin_users/1.json
  def destroy
    user = User.find(@admin_user.user_id)
    user.destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = AdminUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:admin_user).permit(:user_id, :first_name, :last_name)
    end
end
