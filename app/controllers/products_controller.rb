class ProductsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_category

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
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    params = product_params
    if params['logo']
      filename = generate_filename
      Image.upload(params['logo'].tempfile.path, filename)
      params['logo'] = filename
    end

    @product = @category.products.create(params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @category, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    params = product_params
    if params['logo']
      filename = generate_filename
      Image.upload(params['logo'].tempfile.path, filename)
      params['logo'] = filename
    end

    respond_to do |format|
      if @product.update(params)
        format.html { redirect_to @category, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_category
    @category = Category.find(params[:category_id])
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :logo, :is_del, :category_id)
  end

  def generate_filename
    "category-#{Time.now.to_i * 1000 + rand(1000)}"
  end
end
