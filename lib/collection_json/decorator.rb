module CollectionJson::Decorator
  extend ActiveSupport::Concern

  module ClassMethods
    def decorate_collection items, options={}
      Collection.new items, options
    end

    def decorate_item item, options={}
      Item.new item, options
    end

    def decorate object, options={}
      if object.is_a? Enumerable
        decorate_collection object, options
      else
        decorate_item object, options
      end
    end
  end

  module DecoratorShared
    extend ActiveSupport::Concern

    included do
      class_eval do
        attr_accessor :links, :version, :href

        private
        attr_accessor :object
      end
    end

    def setup object, options
      @version    = "1.0"
      @object     = object          #singular or collection of items
      @links      = options[:links] || [options[:link]] #top level links
      @href       = options[:href]  #top level href
    end

    def representation
      {
        collection: {
          version: version,
          href:    href,
          links:   links,
          items:   object
        }
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
      object.map { |i| Item.new(i) }
    end

    def attributes
      items.map &:attributes
    end
  end

  class Item
    include DecoratorShared

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
      debugger
      @attributes = @object.attributes || {}
      @attributes.map{|k,v|  {name: k.to_s, value: v}}
    end
  end
end
