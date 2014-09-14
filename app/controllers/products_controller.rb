class ProductsController < ApplicationController
  before_filter :check_admin, only: [:show, :edit, :update, :destroy,:index]
  before_action :set_product, only: [:show, :edit, :update, :destroy]


  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @menu_categories =  MenuCategory.all
    @categories = Category.all
    @sub_categories = SubCategory.all
  end

  # GET /products/1/edit
  def edit
    @menu_categories =  MenuCategory.all
    @categories = Category.all
    @sub_categories = SubCategory.all
  end

  # POST /products
  # POST /products.json
  def create
    # raise params.inspect
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        flash[:success] = 'Product was successfully created.'
        format.html { redirect_to @product }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        flash[:success] =  'Product was successfully updated.'
        format.html { redirect_to @product }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    flash[:error] = " 'Product was successfully deleted.'"
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def show_product
    if params[:search_data]
      @products = Product.where("name LIKE ?", "%#{params[:search_data]}%").order("created_at DESC")
    end
    if params[:menu_category]
      menu_category_id = params[:menu_category]
      @products = Product.where(:menu_category_id => menu_category_id).order("created_at DESC")
    end
    if params[:category]
      category_id = params[:category]
      @products = Product.where(:category_id => category_id).order("created_at DESC")        
    end
    if params[:sub_category]
      sub_category_id = params[:sub_category]
      @products = Product.where(:sub_category_id => sub_category_id).order("created_at DESC")        
    end
  end

  def update_category_select
    @categories = Category.where(:menu_category_id => params["id"])
    render :layout => false
  end

  def update_sub_category_select
    @sub_categories = SubCategory.where(:category_id => params["id"])
    render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :manufacturer, :menu_category_id, :category_id, :sub_category_id, :description,:image,:size, :feature_list, :stock)
    end
end
