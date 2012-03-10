module CollectionJson::Decorator
  extend ActiveSupport::Concern

  module ClassMethods
    def define_self_link &block
      @self_link_lambda = block
    end

    def define_item_links &block
      @item_link_lambda = block
    end

    def decorate_collection items, options={}
      CollectionJson::Collection.new items, options
    end

    def decorate_item item, options={}, klass=''
      CollectionJson::Item.new item, options
    end

    def decorate object, options={}, &block
      if object.respond_to? :each
        decorate_collection(object, options).tap do |c|
          c.items.each { |i| yield c, i } if block_given?
        end
      else
        item = decorate_item object, options
        yield item if block_given?
        item
      end
    end
  end
end
