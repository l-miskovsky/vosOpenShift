class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :category
      t.float :price
      t.string :shop

      t.timestamps
    end
  end
end
