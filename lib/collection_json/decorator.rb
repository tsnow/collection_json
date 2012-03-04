module CollectionJson::Decorator
  def decorate_collection items, options={}
    Collection.new items, options
  end

  def decorate_item item, options={}
    Item.new item, options
  end

  module DecoratorShared
    extend ActiveSupport::Concern

    included do
      class_eval { attr_reader :links, :href, :version }
    end

    def setup object, options
      @version = "1.0"
      @object = object
      @links = options[:links]
      @href  = options[:href]
    end

    def representation
      { version: version,
        href:    href,
        links:   links,
        items:   @object
      }
    end

    def to_json
      representation.to_json
    end
  end

  class Collection
    include DecoratorShared

    def initialize items, options
      setup items, options
    end

    def items
      @items.map{|i| Item.new(i).attributes}
    end
  end

  class Item
    include DecoratorShared

    def initialize object, options={}
      debugger
      unless object.respond_to? :attributes
        raise CollectionJson::IncompatibleItem.new("Decorated items must have an attributes method")
      end
      setup object, options
    end


    def to_json
      representation.tap do |r|
        r[:items] = [{data: item}]
      end.to_json
    end

    def attributes
      @object.attributes.map{|k,v|  {name: k, value: v}}
    end

    def item
      attributes
    end
  end
end
