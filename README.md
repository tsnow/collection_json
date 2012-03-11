# CollectionJson

An experimental gem to help with producing Hypermedia APIs with a MIME type of
'application/vnd.collection+json'

see http://amundsen.com/media-types/collection/format/


## Usage

The aim is to include the gem in a Rack app to generate hypermedia APIs from
your resources, effectively a hypermedia decorator.

Here's a preview of what you should be able to do in a Rails app:


![Spider cow](https://github.com/markburns/collection_json/raw/master/doc/spider-cow.jpg)

```ruby
class SpiderCowController < ApplicationController
  respond_to :collection_json

  def index
    @spider_cows = SpiderCowDecorator.all do |collection, item|
      collection.href "http://www.youtube.com/watch?v=FavUpD_IjVY"

      item.links [{href: spider_cow_path(item),        rel: "self"},
                  {href: spider_cow_path(item.father), rel: "father"}]
    end

    respond_with @spider_cows
  end
end

class SpiderCow < ActiveRecord::Base
  #attributes - legs, eyes, udders
end

class SpiderCowDecorator
  extend CollectionJson::Decorator
end
```

Sample output:

```javascript
{"collection" :
  {
    "version" :"1.0",
    "href" :"http://example.org/spider_cows/",

    "links" :[ {"rel" :"father", "href" :"http://example.com/spider_cows/tom"}],

    "items" :
    [
      {"data" :
       [{"name" :"legs", "value" :7},
        {"name" :"eyes", "value" :8},
        {"name" :"udders", "value" :"blue"}
       ]
      },

      {"data" :
       [{"name" :"legs",  "value" :6},
        {"name" :"udders", "value" :"red"}
       ]
      }
    ]
  }
}

```


## Installation

Add this line to your application's Gemfile:

    gem 'collection_json'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install collection_json


##Notes

Collection+JSON specifies the following concepts

Create, Read, Update, Delete, Template and Query
which correspond to the ideas in Rails like so:

<table>
  <tr>
    <th>Verb</th><th>Rails</th><th>Collection+JSON</th>
  </tr>
  <tr><td>POST  </td><td>create  </td><td>create</td></tr>
  <tr><td>GET   </td><td>show    </td><td>read</td></tr>
  <tr><td>PUT   </td><td>update  </td><td>update</td></tr>
  <tr><td>DELETE</td><td>destroy </td><td>delete</td></tr>
  <tr><td>GET   </td><td>edit/new</td><td>template</td></tr>
  <tr><td>GET   </td><td>index   </td><td>query</td></tr>
</table>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



