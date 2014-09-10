class SubCategoriesController < ApplicationController
  before_filter :check_admin
  before_action :set_sub_category, only: [:show, :edit, :update, :destroy]

  # GET /sub_categories
  # GET /sub_categories.json
  def index
    @sub_categories = SubCategory.all
    @categories = Category.all
  end

  # GET /sub_categories/1
  # GET /sub_categories/1.json
  def show
  end

  # GET /sub_categories/new
  def new
    @categories = Category.all
    @sub_category = SubCategory.new
  end

  # GET /sub_categories/1/edit
  def edit
    @categories = Category.all
  end

  # POST /sub_categories
  # POST /sub_categories.json
  def create
    @sub_category = SubCategory.new(sub_category_params)

    respond_to do |format|
      if @sub_category.save
        flash[:success] = 'Sub category was successfully created.'
        format.html { redirect_to action: 'index' }
        format.json { render action: 'index', status: :created, location: @sub_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_categories/1
  # PATCH/PUT /sub_categories/1.json
  def update
    respond_to do |format|
      if @sub_category.update(sub_category_params)
        flash[:notice] = 'Sub category was successfully updated.'
        format.html { redirect_to action: 'index'  }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_categories/1
  # DELETE /sub_categories/1.json
  def destroy
    @sub_category.destroy
    respond_to do |format|
      flash[:error] = 'Sub category was successfully deleted.'
      format.html { redirect_to sub_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_category
      @sub_category = SubCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_category_params
      params.require(:sub_category).permit(:sub_category_name, :category_id)
    end
end
