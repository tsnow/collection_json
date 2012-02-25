require File.expand_path('spec/spec_helper')


class HerdOfSpiderCows
  include CollectionJson
  extend CollectionJson::CrudOperations
  extend CollectionJson::Query

  def initialize items, links=[], queries=[], template={}
    @items, @links, @queries, @template = items, links, queries, template
  end
end

#see http://amundsen.com/media-types/collection/format/#link-relations
describe CollectionJson do
  let(:spider_cows) { HerdOfSpiderCows.new [1,2,3],
                      ['/spider_cow/1', '/spider_cow/2', 'spider_cow/3'] }


  describe "#href" do
    specify {spider_cows.href.should == "/herd_of_spider_cows" }

    specify do
      spider_cows.href= "/gathering_of_spider_cows"
      spider_cows.href.should == "/gathering_of_spider_cows"
    end
  end

  describe "#links" do
   specify "has links" do
      spider_cows.links.should ==
        ['/spider_cow/1', '/spider_cow/2', 'spider_cow/3']
    end

   specify do
     spider_cows.links = %w[egg banana cheese]
     spider_cows.links.should == %w[egg banana cheese]
   end
  end

  describe "#collection" do
    specify do
      spider_cows.collection.should be_a Hash
    end

    specify "has items" do
      spider_cows.collection[:items].should == [1,2,3]
    end

    specify "has links" do
      spider_cows.collection[:links].should ==
        ['/spider_cow/1', '/spider_cow/2', 'spider_cow/3']
    end
  end
end


describe CollectionJson::CrudOperations do
  describe ".create" do
    #1.1.2. Adding an Item
    #To create a new item in the collection, the client first uses the template object to compose a valid item representation and then uses HTTP POST to send that representation to the server for processing.

    #If the item resource was created successfully, the server responds with a status code of 201 and a Location header that contains the URI of the newly created item resource.
  end


  describe ".read" do
    #1.1.3. Reading an Item
    #Clients can retrieve an existing item resource by sending an HTTP GET request to the URI of an item resource.
    #If the request is valid, the server will respond with a representation of that item resource.
  end

  describe ".update" do
    #1.1.4. Updating an Item
    #To update an existing resource, the client uses the template object as a guide to composing a replacement item representation and then uses HTTP PUT to send that representation to the server.
    #If the update is successful, the server will respond with HTTP status code 200 and possibly a representation of the updated item resource representation.


  end

  describe ".delete" do
    #1.1.5. Deleting an Item
    #Clients can delete existing resources by sending an HTTP DELETE request to the URI of the item resource.

    #If the delete request is successful, the server SHOULD respond with an HTTP status code of 204.


  end
end

#1.2. Query Templates
#Clients that support the Collection+JSON media type SHOULD be able to recognize and parse query templates found within responses. Query templates consist of a data array associated with an href property. The queries array supports query templates.

#For query templates, the name/value pairs of the data array set are appended to the URI found in the href property associated with the queries array (with a question-mark ["?"] as separator) and this new URI is sent to the processing agent.
describe CollectionJson::Query do

end
