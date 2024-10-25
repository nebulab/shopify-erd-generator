require_relative 'shopify_client'

class ERDGenerator
  def initialize(shop_url, access_token)
    @client = ShopifyClient.new(shop_url, access_token)
    @output = ""
    @relationships = []
    @existing_objects = []
  end

  def generate
    fetch_definitions
    process_metaobjects
    process_metafields
    append_missing_objects
    append_relationships
    write_output
  end

  private

  def fetch_definitions
    puts "\nFetching metaobjects..."
    @metaobjects = @client.fetch_metaobjects
    puts "\nFetching metafields..."
    @metafields = @client.fetch_metafields
  end

  def to_camel(str)
    str.split(/[-_\s]/).inject([]) { |buffer, e| buffer.push(buffer.empty? ? e.downcase : e.capitalize) }.join
  end

  def random_color
    [
      "#ADD8E6", "#B0E0E6", "#AFEEEE", "#87CEEB", "#87CEFA", "#00BFFF", "#1E90FF", "#6495ED", "#4682B4", "#5F9EA0",
      "#B0C4DE", "#B0E0E6", "#ADD8E6", "#87CEEB", "#87CEFA", "#00CED1", "#48D1CC", "#40E0D0", "#00FFFF", "#E0FFFF"
    ].sample
  end

  def process_metaobjects

    @metaobjects.each do |metaobject|
      color = random_color
      object_name = to_camel(metaobject['type'].gsub('shopify--', '').gsub('_', ' '))
      @existing_objects << object_name
      @output += "\n\n\n[#{object_name}] {bgcolor: \"#{color}\", size: \"20\", font: \"Comic Sans MS\" }\n"
      metaobject['fieldDefinitions'].each do |field|
        required = field['required'] ? "not null" : "null"
        label = "#{field['type']['name']}, #{required}"
        key = to_camel(field['key'])
        @output += "  #{key == 'id' ? '*' : ''}#{key} {label: \"#{label}\"}\n"
    
        # Identify relationships based on attribute labels
        if field['type']['name'].end_with?('_reference')
          referenced_object = to_camel(field['type']['name'].split('_')[0...-1].join('_'))
          if referenced_object.include?('list')
            if referenced_object.include?('metaobject')
              @relationships << "#{object_name} 1--* #{key}"
            else
              @relationships << "#{object_name} 1--* #{referenced_object.split('.').last.to_s}"
            end
          else
            if referenced_object.include?('metaobject')
              @relationships << "#{object_name} *--1 #{key}"
            else
              @relationships << "#{object_name} *--1 #{referenced_object}"
            end
          end
        end
      end
    end
  end

  def process_metafields
    @metafields.each do |key, fields|
      next if fields.empty?
      color = random_color
      @existing_objects << key.downcase
      @output += "\n\n\n[#{key}] {bgcolor: \"#{color}\", size: \"20\", font: \"Comic Sans MS\" }\n"
      fields.each do |field|
        required = field['type']['supportsDefinitionMigrations'] ? "not null" : "null"
        label = "#{field['type']['name']}, #{required}"
        name = to_camel(field['name'])
        @output += "#{name} {label: \"#{label}\"}\n"
    
        # Identify relationships based on attribute labels
        if field['type']['name'].end_with?('_reference')
          referenced_object = to_camel(field['type']['name'].split('_')[0...-1].join('_'))
          if referenced_object.include?('list')
            if referenced_object.include?('metaobject')
              @relationships << "#{key} 1--* #{name}"
            else
              @relationships << "#{key} 1--* #{referenced_object.split('.').last.to_s}"
            end
          else
            if referenced_object.include?('metaobject')
              @relationships << "#{key} *--1 #{name}"
            else
              @relationships << "#{key} *--1 #{referenced_object}"
            end
          end
        end
      end
    end
  end

  def append_missing_objects
    @relationships.each do |relationship|
      if relationship.include?(' 1--* ')
        _, referenced_object = relationship.split(' 1--* ')
      elsif relationship.include?(' *--1 ')
        _, referenced_object = relationship.split(' *--1 ')
      end
      unless @existing_objects.include?(referenced_object.strip)
        color = random_color
        @output += "\n\n\n[#{referenced_object.strip}] {bgcolor: \"#{color}\"}\n"
        @existing_objects << referenced_object.strip
      end
    end
  end

  def append_relationships
    @output += "\n# Relationships\n"
    @relationships.each do |relationship|
      @output += "#{relationship}\n"
    end
  end

  def write_output
    header = "title {label: \"Entity-Relationship diagram\", size: \"20\"}\n\n# Entities\n\n"
    @output = header + @output
    File.open('erd-files/metafields.er', 'w') do |file|
      file.write(@output)
    end
    puts "ERD generation completed. Output written to erd-files/metafields.er"
  end
end