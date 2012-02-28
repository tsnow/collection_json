require 'uri'
require 'virtus'

class CollectionJson::Link
  include Virtus
  attribute :href,   String
  attribute :rel,    String
  attribute :prompt, String
  attribute :name,   String
  attribute :render, String

  def initialize *args
    debugger
    super args
    self.href = URI.parse(href).to_s

  rescue URI::InvalidURIError => e
    raise CollectionJson::InvalidUriError.new "#{args}" +  e.message
  end


  #3.4. links
  #The links array is an OPTIONAL child property of the items array.
  #It SHOULD contain one or more anonymous objects.
  #Each has five possible properties: href (REQUIRED), rel (REQURIED),
  #name (OPTIONAL), render (OPTIONAL), and prompt, (OPTIONAL).
  def valid?
    href.present? and rel.present?
  end
end
