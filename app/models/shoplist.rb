class Shoplist < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name

  has_many :item_in_lists, dependent: :destroy
  has_many :products, through: :item_in_lists

  def make_order products
    shops = ["Billa", "Carrefour", "Kaufland", "Lidl", "Tesco"]
#map it shops na ceny + vyratat average
#vo view uz len preiterovat

    ordProducts = ActiveSupport::OrderedHash.new

    products.each_with_index do |product,index|      #pre kazdy produkt
      prices = product.prices       #get jeho zname ceny

      ordPrices = ActiveSupport::OrderedHash.new   #vytvor ciast. objekt na vopchatie usortenych cien/shop

      (0..shops.length-1).each do |index|        #prejdi vsetky shopy
        done = false
        sum = 0
        prices.each do |price|      #prejdi vsetky ceny a najdi taku s akt. shopom
          sum += price.price
          if(price.shop == shops[index])
            done = true
            ordPrices[price.shop] = price.price#daj do OrderedHash
          end
        end
        if(!done)
          if(prices.length==0)
            ordPrices[shops[index]] = '-'
          else
            cena = sum/prices.length #ak nie je v db, daj tam avg vsetkych
            ordPrices[shops[index]] = sprintf('%.2f', cena)
          end
        end
      end
      ordProducts[product] = ordPrices
    end
    ordProducts
  end
end
