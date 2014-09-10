class MenuCategoriesController < ApplicationController
  before_filter :check_admin
  before_action :set_menu_category, only: [:show, :edit, :update, :destroy]

  # GET /menu_categories
  # GET /menu_categories.json
  def index
    @menu_categories = MenuCategory.all
  end

  # GET /menu_categories/1
  # GET /menu_categories/1.json
  def show
  end

  # GET /menu_categories/new
  def new
    @menu_category = MenuCategory.new
  end

  # GET /menu_categories/1/edit
  def edit
  end

  # POST /menu_categories
  # POST /menu_categories.json
  def create
    @menu_category = MenuCategory.new(menu_category_params)

    respond_to do |format|
      if @menu_category.save
        format.html { redirect_to @menu_category, notice: 'Menu category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @menu_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @menu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_categories/1
  # PATCH/PUT /menu_categories/1.json
  def update
    respond_to do |format|
      if @menu_category.update(menu_category_params)
        format.html { redirect_to @menu_category, notice: 'Menu category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @menu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_categories/1
  # DELETE /menu_categories/1.json
  def destroy
    @menu_category.destroy
    respond_to do |format|
      format.html { redirect_to menu_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_category
      @menu_category = MenuCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_category_params
      params.require(:menu_category).permit(:menu_text)
    end
end
