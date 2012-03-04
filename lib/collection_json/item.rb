module CollectionJson
  class Item
    include Decorator::Shared

    def initialize object, options={}
      unless object.respond_to? :attributes
        raise CollectionJson::IncompatibleItem.new("Decorated items must have an attributes method")
      end
      setup object, options
    end

    def representation
      {
        collection: {
          version: version,
          href:    href,
          links:   links,
          items:   [{data: attributes}]
        }
      }
    end

    def attributes
      @attributes = @object.attributes || {}
      @attributes.map{|k,v|  {name: k.to_s, value: v}}
    end
  end
end
