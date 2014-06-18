class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.float :price
      t.string :shop
      t.integer :product_id

      t.timestamps
    end
  end
end
