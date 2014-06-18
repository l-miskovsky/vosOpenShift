class RemovePriceAndShopFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :price, :float
    remove_column :products, :shop, :string
  end
end
