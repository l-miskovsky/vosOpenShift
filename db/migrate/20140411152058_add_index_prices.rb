class AddIndexPrices < ActiveRecord::Migration
  def change
    add_index :prices, :product_id
  end
end
