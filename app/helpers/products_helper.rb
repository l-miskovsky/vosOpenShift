module ProductsHelper

  def shoplist_add_product(product)
    shoplist = current_user.shoplists[1]
    shoplist.item_in_lists.create(product: product)
  end

end
