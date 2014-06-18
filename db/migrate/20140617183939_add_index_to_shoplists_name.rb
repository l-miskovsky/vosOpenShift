class AddIndexToShoplistsName < ActiveRecord::Migration
  def change
    add_index :shoplists, [:user_id, :name]
  end
end
