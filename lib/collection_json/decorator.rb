module CollectionJson::Decorator
  extend ActiveSupport::Concern

  module ClassMethods
    def decorate_collection items, options={}
      CollectionJson::Collection.new items, options
    end

    def decorate_item item, options={}
      CollectionJson::Item.new item, options
    end

    def decorate object, options={}
      if object.is_a? Enumerable
        decorate_collection object, options
      else
        decorate_item object, options
      end
    end
  end

  module Shared
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
end
