# Crawler & parser
require 'open-uri'
require 'nokogiri'

#na doplnenie potrebneho poctu nul do adresy kvoli formatu tesco URLky
def format_category id
  dlzka=id.length
  id = '0'*(8-dlzka)+id
end

namespace :db do
  desc 'Fill database with data from itesco.sk'
  task itesco: :environment do
    (911..923).each do |id| #kategorie
      id = format_category id.to_s #


      html = open("http://potravinydomov.itesco.sk/sk-SK/Product/BrowseProducts?taxonomyId=Cat#{id}")
      doc = Nokogiri::HTML(html, nil, 'UTF-8')
      error = doc.xpath('//*[@id="errorPage"]/div').text
      unless (error != '')
        posledna = doc.search('.pagination').search('li').last.text.gsub(/Strana:(?<foo>\d)z\d/, '\k<foo>').to_i
        kategoria = doc.xpath('//*[@id="filterResults"]/h1').text.gsub(/\r/, '')

        puts "Kategoria: #{kategoria} (#{id})"
        page=1
        unless(kategoria == '')
          while (page <= posledna) do #pagination v konkretnej kategorii
            puts "Strana: #{page}"
            html2= open("http://potravinydomov.itesco.sk/sk-SK/Product/BrowseProducts?taxonomyID=Cat#{id}&pageNo=#{page}")
            doc2 = Nokogiri::HTML(html2, nil, 'UTF-8')

            doc2.search('.t.product').each do |produkt|

              meno = produkt.search('h2 a').text.gsub(/[.\r]/,'')

              cena = produkt.search('.price').text.split(' ')
              cena_float = cena[0].sub(',','.').to_f

              platnostDo = produkt.search('.promoUntil').text
              platnostDo.sub!(/.*?(?=\d)/im, '')

              item = Product.find_by_name(meno)
              if item.nil? then
                item = Product.create(name: meno, category: kategoria)
                item.prices.create!(price: cena_float, shop: 'Tesco', until: platnostDo)
              else
                item.prices.where(shop: 'Tesco').destroy_all
                item.prices.create!(price: cena_float, shop: 'Tesco', until: platnostDo)
              end

            end
            page +=1
          end
        end
      end
    end
  end
end

