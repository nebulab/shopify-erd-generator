require 'irb'
require_relative 'shopify_client'

puts "Enter shop url:"

shop_url = gets.chomp

puts "\nEnter access token:"

access_token = gets.chomp

client = ShopifyClient.new(shop_url, access_token)

puts "\nFetching metaobjects..."
metaobjects = client.fetch_metaobjects
puts metaobjects
puts "\nFetching metaobjects..."
metafields = client.fetch_metafields
puts metafields

IRB.start