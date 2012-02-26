require 'active_support/deprecation'
require 'active_support/concern'
require 'virtus'

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
      class_eval do
        def self.url *args
          return @url = args[0] if args.any?
          @url
        end

        def self.rel *args
          return @rel = args[0] if args.any?
          @rel
        end

        def self.prompt *args
          return @prompt = args[0] if args.any?
          @prompt
        end

        def self.query
          yield
        end

      end
    end
  end
end
