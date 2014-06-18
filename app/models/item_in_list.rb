class ItemInList < ActiveRecord::Base
  belongs_to :product
  belongs_to :shoplist
end
