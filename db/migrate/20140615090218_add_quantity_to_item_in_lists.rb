class AddQuantityToItemInLists < ActiveRecord::Migration
  def change
    add_column :item_in_lists, :quantity, :integer
  end
end
