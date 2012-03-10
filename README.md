# CollectionJson

An experimental gem to help with producing Hypermedia APIs with a MIME type of
'application/vnd.collection+json'

see http://amundsen.com/media-types/collection/format/

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
  <tr><td>PUT  </td> <td>update  </td><td>update</td></tr>
  <tr><td>DELETE</td><td>destroy </td><td>delete</td></tr>
  <tr><td>GET   </td><td>edit/new</td><td>template</td></tr>
  <tr><td>GET   </td><td>index   </td><td>query</td></tr>
</table>

## Installation

Add this line to your application's Gemfile:

    gem 'collection_json'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install collection_json

## Usage

This is still experimental at the moment.
The aim is to be able to include the gem in a Rack app and make for easy
generation of hypermedia APIs from your resources, effectively something like a
hypermedia presenter.

Here's a preview of what you should be able to do in a Rails app:


![Spider cow](https://github.com/markburns/collection_json/raw/master/doc/spider-cow.jpg)

```ruby
class SpiderCowController < ApplicationController
  respond_to :collection_json

  def index
    @spider_cows = SpiderCowDecorator.all do |s|
      s.href spider_cows_path
      s.item_links [{hspider_cowref: spider_cow_path(s), rel: "self"}]
    end

    respond_with @spider_cows
  end
end

class SpiderCow < ActiveRecord::Base
  #attributes - legs, eyes, udders
end

class SpiderCowDecorator
  include CollectionJson::Decorator
end
```

Sample output:

```javascript
{"collection" :
  {
    "version" :"1.0",
    "href" :"http://example.org/spider_cow/",

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
