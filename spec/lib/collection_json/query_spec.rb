require File.expand_path('spec/spec_helper')

#1.2. Query Templates
#Clients that support the Collection+JSON media type SHOULD be able to
#recognize and parse query templates found within responses.
#Query templates consist of a data array associated with an href property. The
#queries array supports query templates.

#For query templates, the name/value pairs of the data array set are appended
#to the URI found in the href property associated with the queries array (with
#a question-mark ["?"] as separator) and this new URI is sent to the processing
#agent.

#In the above example, if the user supplied "JSON" for the value property, the
#user agent would construct the following URI:

#http://example.org/search?search=JSON
class Book
  include CollectionJson::Query

  url "http://example.org/search"
  rel "search"
  prompt "Enter search string"

  attribute :title,         String
  attribute :author,        String
  attribute :publish_date,  DateTime
  attribute :readers_count, Integer
end

describe CollectionJson::Query do
  let(:query_template) do
    # query template sample
    {
      queries:
      [
        {
          href: "http://example.org/search",
          rel: "search",
          prompt: "Enter search string",
          data:
          [
            {name: "title",         value: "The long and winding road"},
            {name: "author",        value: "Jack Smith"},
            {name: "publish_date",  value: clock_tower_time},
            {name: "readers_count", value: nil}
          ]
        }
      ]
    }
  end
 let(:query_template_with_count) do
    # query template sample
    {
      queries:
      [
        {
          href: "http://example.org/search",
          rel: "search",
          prompt: "Enter search string",
          data:
          [
            {name: "title",         value: "The long and winding road"},
            {name: "author",        value: "Jack Smith"},
            {name: "publish_date",  value: clock_tower_time},
            {name: "readers_count", value: 10}
          ]
        }
      ]
    }
  end

  let(:clock_tower_time){DateTime.parse("1955-11-05T20:00:00+09:00")}

  let(:book) do
    Book.new title: "The long and winding road", author: "Jack Smith",
      publish_date: clock_tower_time
  end

  specify { book.query_template.should == query_template }

  specify do
    book.readers_count=10
    book.query_template.should == query_template_with_count
  end
end
