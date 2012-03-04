require 'active_support/deprecation'
require 'active_support/concern'
require 'virtus'
require 'virtus/attribute'


#3.3. queries
#The queries array is an OPTIONAL top-level property of the
#Collection+JSON document.
#The collection object MAY have an queries
#array child property.
module CollectionJson
  module Query
    extend ActiveSupport::Concern
    include Virtus

    def to_json
      query_template.to_json
    end

    def query_template
      {
        queries:
        [
          {
            href:   self.class.url,
            rel:    self.class.rel,
            prompt: self.class.prompt,
            data:   attributes.map{|k, v| {name: k.to_s, value: v}}
         }
        ]
      }
    end

    included do
      class << self
        [:url, :rel, :prompt].each do |a|
          define_method a do |*args|
            return instance_variable_set("@#{a}", args[0]) if args.any?
            instance_variable_get "@#{a}"
          end
        end
      end
    end
  end
end
