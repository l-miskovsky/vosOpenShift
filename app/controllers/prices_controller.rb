class PricesController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @price = @product.prices.create(price_params)
    redirect_to @product
  end

  def edit
    @cena = Price.find(params[:id])
    @product = Product.find_by_id(@cena.product_id)
  end

  def update
    @price = Price.find(params[:id])
    @product = Product.find_by_id(@price.product_id)

    @price.price = params[:price][:price].gsub(',','.')
    if @price.save
      redirect_to @product
    else
      redirect_to @product
      #TODO add error messages
    end
  end

  private
  def price_params
    params.require(:price).permit(:price, :shop, :until)
  end
end
