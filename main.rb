require_relative 'erd_generator'

shop_url = ENV['SHOP_URL']
access_token = ENV['ACCESS_TOKEN']
ERDGenerator.new(shop_url, access_token).generate