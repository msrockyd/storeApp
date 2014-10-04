class UserDetailsController < ApplicationController
  # before_action :set_user_detail, only: [:show, :edit, :update, :destroy]

  # GET /user_details
  # GET /user_details.json
  def index
    @user_detail = UserDetail.where(:user_id=> current_user.id).first
  end

  # GET /user_details/1
  # GET /user_details/1.json
  def show
  end

  # GET /user_details/new
  def new
    @user_detail = UserDetail.new
  end

  # GET /user_details/1/edit
  def edit
    @user_detail = UserDetail.where(:user_id=> current_user.id).first
  end

  # POST /user_details
  # POST /user_details.json
  def create
    @user_detail = UserDetail.new(user_detail_params)

    respond_to do |format|
      if @user_detail.save
        format.html { redirect_to @user_detail, notice: 'User detail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_detail }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_details/1
  # PATCH/PUT /user_details/1.json
  def update
    # raise params.inspect
    user_id = current_user.id
    user_detail = UserDetail.where(:user_id => current_user.id).first
    if user_detail.blank?
      UserDetail.create({:user_id => current_user.id, :first_name => params[:first_name],
              :last_name=> params[:last_name], :gender=> params[:gender],
              :phone_number=> params[:phone_number]})
      flash[:success] = 'User detail was successfully Updated.'
    else
      user_detail.update_attributes({:user_id => current_user.id, :first_name => params[:first_name],
              :last_name=> params[:last_name], :gender=> params[:gender],
              :phone_number=> params[:phone_number]})
      flash[:success] = 'User detail was successfully Updated.'
    end
    redirect_to :action => :index
  end

  # DELETE /user_details/1
  # DELETE /user_details/1.json
  def destroy
    @user_detail.destroy
    respond_to do |format|
      format.html { redirect_to user_details_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_detail
      @user_detail = UserDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_detail_params
      params.require(:user_detail).permit(:user_id, :first_name, :last_name, :gender, :phone_number)
    end
end
