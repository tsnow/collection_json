module CollectionJson
  class Collection
    attr_accessor :items, :version, :template
    extend FunkyAccessor
    funky_accessor :href, :links

    def initialize items
      @version    = "1.0"
      @items      = items.map { |i| Item.new(i) }
      @template = @items.first.blank_template if @items.any?
      @links = []
    end

    def representation
      collection = {
          version:  version,
          href:     href,
          links:    links,
          items:    item_representations
        }

      collection.merge!({template: {data: template}}) if template

      {collection: collection}
    end

    def to_json
      representation.to_json
    end

    def item_representations
      items.map &:singular_representation
    end
  end
end
