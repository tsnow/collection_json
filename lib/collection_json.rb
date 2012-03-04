require "active_support/dependencies/autoload"
require "active_support/version"
require 'json'
require 'virtus'

require 'active_support/lazy_load_hooks'
require 'active_support/concern'
require 'active_support/core_ext/string'
require 'active_support/core_ext/hash'
require 'collection_json/version'
require 'draper'

#see http://amundsen.com/media-types/collection/format/#link-relations

debugger
#  2.1. collection
# The collection object contains all the "records" in the representation.
# This is a REQUIRED object and there MUST NOT be more than one collection
# object in a Collection+JSON document.
# It is a top-level document property.
module CollectionJson
  extend ActiveSupport::Autoload

  autoload :Rack
  autoload :Collection
  autoload :Link
  autoload :InvalidJsonError, 'collection_json/exceptions'
  autoload :Item
  autoload :Query
  autoload :Template
  autoload :InvalidUriError,  'collection_json/exceptions'
  autoload :IncompatibleItem, 'collection_json/exceptions'
  autoload :Decorator


  def self.included base
    base.class_eval do
      attr_writer :href
      attr_accessor  :items, :queries, :links, :items, :template, :error



      #3.3. queries
      #The queries array is an OPTIONAL top-level property of the
      #Collection+JSON document.
      #The collection object MAY have an queries
      #array child property.

      #3.4 links
      #The links array is an OPTIONAL child property of the items array
      #The Collection+JSON hypermedia type has a limited set of predefined link
      #relation values and supports additional values applied by implementors
      #in order to better describe the application domain to which the media
      #type is applied.
      ##The collection object MAY have an links array child property

      #The collection object MAY have an items array child property.
      #Each item in a Collection+JSONcollection has an assigned URI
      #(via the href property) and an optional array of one or more data
      #elements along with an optional array of one or more link elements.

      #The collection object MAY have an template object child property.

      #The template object contains all the input elements used to add or edit
      #collection "records." This is an OPTIONAL object and there MUST NOT be more
      #than one template object in a Collection+JSON document.
      #It is a top-level document property.
      #The template object SHOULD have a data array child property.

      #2.2. error
      #The error object contains addiitional information on the latest error
      #condition reported by the server.
      #This is an OPTIONAL object and there MUST NOT be more than one error
      #object in a Collection+JSON document.
      #
      #It is a top-level document property.
      #
      #The following elements MAY appear as child properties of the error object:
      #code message and title.


      #Error = Struct.new :code, :message, :title
      #The collection object MAY have an error object child property.

      #The collection object SHOULD have a version property.
      # For this release, #the value of the version property MUST be set to 1.0.
      # If there is no version property present, it should be assumed to be set
      # to 1.0.
      def version
        "1.0"
      end
    end
  end

  def to_json
    {collection: collection}.to_json
  end
end
