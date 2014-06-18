class CreateItemInLists < ActiveRecord::Migration
  def change
    create_table :item_in_lists do |t|
      t.integer :product_id
      t.integer :shoplist_id

      t.timestamps
    end
  end
end
