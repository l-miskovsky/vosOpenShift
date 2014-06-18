class Price < ActiveRecord::Base
  validates_presence_of :price, :shop
  validates_numericality_of :price, greater_than: 0

  validates :product_id, uniqueness: {scope: [:product_id, :shop]}

  belongs_to :product
end
