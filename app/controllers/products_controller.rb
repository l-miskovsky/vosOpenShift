class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def listing
    #TODO fix facets for nil category
    @search = Product.search(include: :prices) do
      fulltext params[:search]
      facet :category, sort: :index
      order_by :name, :asc
      with :category, params[:category] if params[:category].present?
      paginate(page: params[:page], per_page: 35)
    end
    @products = @search.results
    self.new
  end

  def index #vypis vsetkych + pridavanie do shoplistov
    self.listing
    @shoplist = Shoplist.find(params[:shoplist_id])
  end

  def ins
    @shoplist = current_user.shoplists.find(params[:shoplist_id])

    @shoplist.item_in_lists.create(product_id: params[:id], quantity: params[:pocet])
    redirect_to :back
  end

  def show
    @product = Product.find(params[:id])
    @prices = @product.prices.paginate(page: params[:page])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to :back
    else
      render 'new'
    end
  end

  def destroy
  end

  private
  def product_params
    params.require(:product).permit(:name, :price)
  end
end
