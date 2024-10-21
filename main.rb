require 'irb'
require_relative 'shopify_client'

shop_url = ENV['SHOP_URL']
access_token = ENV['ACCESS_TOKEN']

client = ShopifyClient.new(shop_url, access_token)

puts "\nFetching metaobjects..."
metaobjects = client.fetch_metaobjects
puts "\nFetching metaobjects..."
metafields = client.fetch_metafields

# Method to convert to camelCase
def to_camel(str)
  str.split(/[-_\s]/).inject([]) { |buffer, e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
end

# Method to generate a random color in hex format
def random_color
  "#" + "%06x" % (rand * 0xffffff)
end

# Transform the definitions to the desired format
output = ""
relationships = []
existing_objects = []

metaobjects.each do |metaobject|
  color = random_color
  object_name = to_camel(metaobject['type'].gsub('shopify--', '').gsub('_', ' '))
  existing_objects << object_name
  output += "\n\n\n[#{object_name}] {bgcolor: \"#{color}\"}\n"
  metaobject['fieldDefinitions'].each do |field|
    required = field['required'] ? "not null" : "null"
    label = "#{field['type']['name']}, #{required}"
    key = to_camel(field['key'])
    output += "  #{key == 'id' ? '*' : ''}#{key} {label: \"#{label}\"}\n"

    # Identify relationships based on attribute labels
    if field['type']['name'].end_with?('_reference')
      referenced_object = to_camel(field['type']['name'].split('_')[0...-1].join('_'))
      unless referenced_object.include?('metaobject')
        relationships << "#{object_name} 1--1 #{referenced_object} "
      end
    end
  end
end

metafields.each do |key, fields|
  next if fields.empty?
  color = random_color
  existing_objects << key
  output += "\n\n\n[#{key}] {bgcolor: \"#{color}\"}\n"
  fields.each do |field|
    required = field['type']['supportsDefinitionMigrations'] ? "not null" : "null"
    label = "#{field['type']['name']}, #{required}"
    name = to_camel(field['name'])
    output += "#{name} {label: \"#{label}\"}\n"

    # Identify relationships based on attribute labels
    if field['type']['name'].end_with?('_reference')
      referenced_object = to_camel(field['type']['name'].split('_')[0...-1].join('_'))
      unless referenced_object.include?('metaobject')
        relationships << "#{key} 1--1 #{referenced_object}"
      end
    end
  end
end

header = "title {label: \"nfldb Entity-Relationship diagram (condensed)\", size: \"20\"}\n\n# Entities\n\n"
output = header + output

# Append missing objects to the output
relationships.each do |relationship|
  _, referenced_object = relationship.split(' 1--1 ')
  unless existing_objects.include?(referenced_object.strip)
   color = random_color
   output += "\n\n\n[#{referenced_object.strip}] {bgcolor: \"#{color}\"}\n"
    existing_objects << referenced_object.strip
    end
end

# Append relationships to the output
output += "\n# Relationships\n"
relationships.each do |relationship|
  output += "#{relationship}\n"
end

# Write the output to a file
File.open('erd-files/metafields.er', 'w') do |file|
  file.write(output)
end
