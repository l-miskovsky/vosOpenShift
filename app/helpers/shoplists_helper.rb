module ShoplistsHelper
  def format_price quantity, price
    (price == '-') ? price : (price.to_f * quantity).round(2)
  end
end
