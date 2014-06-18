# encoding: utf-8
#custom rake for some db manipulations
namespace :db do
  desc 'Update database'
  task custom_dbchange: :environment do
    Product.update_all( "category = 'Cestoviny a ryža'", "category LIKE 'Cestoviny, ryža%'" )







  end
end