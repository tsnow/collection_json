require "active_support/dependencies/autoload"
require "active_support/version"
require 'active_support/core_ext/module/delegation'
#require "delegate"
require 'json'
require 'virtus'

require 'active_support/lazy_load_hooks'
require 'active_support/concern'
require 'active_support/core_ext/string'
require 'active_support/core_ext/hash'
require 'collection_json/gem_version'
require 'draper'

require 'active_support/deprecation'
require 'active_support/concern'
require 'virtus'
require 'virtus/attribute'
require 'funky_accessor'

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
  autoload :Item
  autoload :Query
  autoload :Template

  autoload :InvalidJsonError, 'collection_json/exceptions'
  autoload :InvalidUriError,  'collection_json/exceptions'
  autoload :IncompatibleItem, 'collection_json/exceptions'

  autoload :Decorator
end
