module CollectionJson
  class Collection
    include Decorator::Shared

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
end
