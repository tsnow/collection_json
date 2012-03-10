#The collection object MAY have an items array child property.
#Each item in a Collection+JSONcollection has an assigned URI
#(via the href property) and an optional array of one or more data
#elements along with an optional array of one or more link elements.
module CollectionJson
  class Item < SimpleDelegator
    attr_accessor :version, :object
    extend FunkyAccessor
    funky_accessor :href, :links



    def initialize object, options={}
      unless object.respond_to? :attributes
        raise CollectionJson::IncompatibleItem.new("Decorated items must have an attributes method")
      end
      super object

      @version    = "1.0"
      @object     = object          #singular or collection of items
      @links      = options[:links] || [] #top level links
      @href       = options[:href]  #top level href
    end

    def to_json
      representation.to_json
    end

    def link l=nil
      return links [l] if l
      links
    end

    def singular_representation
      item = {}
      item.merge!({href: href})       if href
      item.merge!({data: attributes}) if attributes.any?
    end

    def representation
      r = { version: version}

      r.merge!({href: href})          if href
      r.merge!({links: links})        if links
      r.merge!({items: [singular_representation]})

      { collection: r }
    end

    def attributes
      @attributes = @object.attributes || {}
      @attributes.map{|k,v|  {name: k.to_s, value: v}}
    end
  end
end
