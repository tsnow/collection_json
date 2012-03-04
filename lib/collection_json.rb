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
      #The collection object SHOULD have a version property.
      # For this release, #the value of the version property MUST be set to 1.0.
      # If there is no version property present, it should be assumed to be set
      # to 1.0.
      def version
        "1.0"
      end
    end
  end
end
