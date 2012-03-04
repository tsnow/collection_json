require File.expand_path('spec/spec_helper')

class HerdOfSpiderCows
  include CollectionJson
  extend CollectionJson::Interactions
end

describe CollectionJson::Interactions do
  let(:spider_cows) do
    HerdOfSpiderCows.new items: [1,2,3],
      links: ['/spider_cow/1', '/spider_cow/2', 'spider_cow/3'],
      queries: [],
      template: CollectionJson::Template.new(:legs, :eyes)
  end

  #1.1.2. Adding an Item
  #POST /my-collection/ HTTP/1.1
  #Host: www.example.org
  #Content-Type: application/vnd.collection+json

  #{ "template" : { "data" : [ ...] } }

  #*** RESPONSE ***
  #201 Created HTTP/1.1
  #Location: http://www.example.org/my-collection/1


  describe ".create" do
    #1.1.2. Adding an Item
    #To create a new item in the collection, the client first uses the template object to compose a valid item representation and then uses HTTP POST to send that representation to the server for processing.

    #If the item resource was created successfully, the server responds with a status code of 201 and a Location header that contains the URI of the newly created item resource.
  end


  #1.1.1. Reading Collections
  #GET /my-collection/ HTTP/1.1
  #Host: www.example.org
  #Accept: application/vnd.collection+json

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
