#The collection object MAY have an items array child property.
#Each item in a Collection+JSONcollection has an assigned URI
#(via the href property) and an optional array of one or more data
#elements along with an optional array of one or more link elements.
module CollectionJson
  class Item < SimpleDelegator
    attr_accessor :links, :version, :href

    def initialize object, options={}
      super object

      unless object.respond_to? :attributes
        raise CollectionJson::IncompatibleItem.new("Decorated items must have an attributes method")
      end

      @version    = "1.0"
      @object     = object          #singular or collection of items
      @links      = options[:links] || [options[:link]] #top level links
      @href       = options[:href]  #top level href
    end

    def to_json
      representation.to_json
    end

    def item_link arg=nil, &block
      item_links arg, &block
    end

    def item_links arg=nil
      if block_given?
        @item_links = yield
      elsif arg
        @item_links = arg
      else
        @item_links
      end
    end

    def href arg=nil
      if block_given?
        @href = yield
      elsif arg
        @href = arg
      else
        @href
      end
    end

    def links arg=nil
      if block_given?
        @links = yield
      elsif arg
        @links = arg
      else
        @links
      end
    end

    def link arg=nil
      if block_given?
        @links = [yield]
      elsif arg
        @links = [arg]
      else
        @links.first
      end
    end

    def self_link
      if block_given?
        @self_link = yield
      else
        @self_link
      end
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
