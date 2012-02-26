# CollectionJson

An experimental gem to help with producing Hypermedia APIs with a MIME type of
'application/vnd.collection+json'

see http://amundsen.com/media-types/collection/format/#link-relations

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

I'm not clear on the details of how the objects will be presented as
Collection+JSON as there is an emphasis on Collections rather than individual
items. This makes sense if you think of Rails controllers being plural.

But it is reasonably different to being used to having the primary unit of data
being a singular model.

```ruby
  SingularActiveRecordObject.all

  #versus:
  PluralJsonCollection.new collection_of_objects
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
