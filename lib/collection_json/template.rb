#The template object contains all the input elements used to add or edit
#collection "records." This is an OPTIONAL object and there MUST NOT be more
#than one template object in a Collection+JSON document.
#It is a top-level document property.
#The template object SHOULD have a data array child property.
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
