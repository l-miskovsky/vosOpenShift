require 'open-uri'
require 'nokogiri'

namespace :db do
  desc "Fill database with data from zlacnene.sk"
  task fillup: :environment do
#zlacnene.sk
    Price.destroy_all 'until<current_date'
    (1..56).each do |id|
      html = open("http://www.zlacnene.sk/tovar/hladaj/sk-potraviny/p/#{id}")
      doc = Nokogiri::HTML(html)

      doc.search('.zboziVypis').each do |produkt|
        meno = produkt.search('h2 a').text
        cena = produkt.search('.cena').text.split(' ')
        obchod = produkt.search('.prodejnaName').text
        platnostDo = produkt.search('.platiDo').text
        temp = cena[1].sub(',','.').to_f
        item = Product.find_by_name(meno)

        if item.nil? then
          item = Product.create(name: meno)
          item.prices.create!(price: temp, shop: obchod, until: platnostDo)
        else
          item.prices.where(shop: obchod).destroy_all
          item.prices.create!(price: temp, shop: obchod, until: platnostDo)
        end
      end
    end
  end
end