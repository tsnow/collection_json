module CollectionJson::Decorator
  extend ActiveSupport::Concern

  module ClassMethods
    def decorate_collection items, options={}
      Collection.new items, options
    end

    def decorate_item item, options={}
      Item.new item, options
    end
  end


  class Collection
    attr_reader :links, :href
    def initialize items, options
      @items = items
      @links = options[:links]
      @href  = options[:href]
    end

    def to_json
      { version: "1.0",
        href:    href,
        links:   links,
        items:   items
      }.to_json
    end

    def items
      @items.map{|i| i.attributes.map{|k,v| {name: k, value: v}}}
    end
  end

  class Item
    attr_reader :links, :href
    def initialize item, options={}
      unless item.respond_to? :attributes
        raise CollectionJson::IncompatibleItem.new("Decorated items must have an attributes method")
      end

      @item  = item
      @links = options[:links]
      @href  = options[:href]
    end

    def to_json
      { version: "1.0",
        href:    href,
        links:   links,
        items:   [{data: item}]
      }.to_json
    end

    def item
      @item.attributes.map{|k,v|  {name: k, value: v}}
    end
  end
end
