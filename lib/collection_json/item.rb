#The collection object MAY have an items array child property.
#Each item in a Collection+JSONcollection has an assigned URI
#(via the href property) and an optional array of one or more data
#elements along with an optional array of one or more link elements.
module CollectionJson
  class Item < SimpleDelegator
    extend FunkyAccessor
    funky_accessor :href, :links, :version, :object

    def initialize object
      @object  = object
      pre_check
      super object

      @links   = []
      @version = "1.0"
    end

    def to_json
      representation.to_json
    end

    def template
      attributes.map{|h| h[:value]=""; h }
    end

    def singular_representation
      item = {}
      item.merge!({href: href})       if href
      item.merge!({data: attributes}) if attributes.any?
    end

    def representation
      r = { version: version}

      r.merge!({href:  href})         if href
      r.merge!({links: links})        if links
      r.merge!({items: [singular_representation]})

      { collection: r }
    end

    def attributes
      @attributes = @object.attributes || {}
      @attributes.map{|k,v|  {name: k.to_s, value: v}}
    end

    private

    def pre_check
      unless object.respond_to? :attributes
        raise CollectionJson::IncompatibleItem.new("Decorated items must have an attributes method")
      end
    end
  end
end
