module CollectionJson
  class Template
    def initialize *attributes
      @attributes = attributes
    end

    def to_json
      @attributes.map{|a| {name: a, value: ""}}.to_json
    end
  end
end
