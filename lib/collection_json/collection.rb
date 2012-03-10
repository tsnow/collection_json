module CollectionJson
  class Collection
    attr_accessor :items, :version
    extend FunkyAccessor
    funky_accessor :href, :links



    def initialize items, options
      @version    = "1.0"
      @items      = items.map do |i|
        Item.new(i)
      end

      #top level links
      @links      = options[:links] || []
      @href       = options[:href]  #top level href
    end

    def link l=nil
      return links [l] if l
      links
    end

    def representation
      {
        collection: {
          version: version,
          href:    href,
          links:   links,
          items:   item_representations
        }
      }
    end

    def to_json
      representation.to_json
    end

    def item_representations
      items.map &:singular_representation
    end
  end
end
