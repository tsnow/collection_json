module CollectionJson
  class Collection
    attr_accessor :items, :links, :href, :version

    def initialize items, options
      @version    = "1.0"
      @items      = items.map { |i| Item.new(i) }
      @links      = options[:links] || [options[:link]] #top level links
      @href       = options[:href]  #top level href
    end

    def representation
      {
        collection: {
          version: version,
          href:    href,
          links:   links,
          items:   attributes
        }
      }
    end

    def to_json
      representation.to_json
    end

    def attributes
      items.map &:attributes
    end
  end
end
