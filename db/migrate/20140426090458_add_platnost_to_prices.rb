class AddPlatnostToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :until, :date
  end
end
