class Product < ActiveRecord::Base
  validates_presence_of :name
  validates :name, uniqueness: true

  has_many :prices, dependent: :destroy

  has_many :item_in_lists
  has_many :shoplists, through: :item_in_lists

  searchable do
    text :name
    string :category
    string :name
  end
end
