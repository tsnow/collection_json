require File.expand_path('spec/spec_helper')

class BananaFish < OpenStruct
  def attributes
    @table
  end
end

class BananaFishDecorator
  include CollectionJson::Decorator
end

describe CollectionJson::Decorator do
  class SpiderCowDecorator
    include CollectionJson::Decorator
  end

  def cow(id) mock 'spider_cow', link: id, attributes: {name: "cow_#{id}"} end

  let(:items) {[cow(1), cow(2), cow(3)]}

  let(:links) {[{rel: "next", href: "spider_cows/?page=3"}] }

  #crazy archaic plural I'd never heard of, cow -> kine. Thanks ActiveSupport
  let(:href) { "/spider_kine" }

  let(:spider_cows) do
    SpiderCowDecorator.decorate items, href: href, links: links
  end

  describe "#href" do
    specify { spider_cows.href.should == "/spider_kine" }

    specify do
      spider_cows.href "/spider_cows"
      spider_cows.href.should == "/spider_cows"
    end
  end

  describe "#links" do
    specify { spider_cows.links.should == links }

    specify do
      spider_cows.links           %w(egg banana cheese)
      spider_cows.links.should == %w(egg banana cheese)
    end
  end

  describe "#representation" do
    specify do
      spider_cows.representation.should be_a Hash
    end

    specify "has items" do
      spider_cows.representation[:collection][:items].should ==
        [{data: [{:name=>"name", :value=>"cow_1"}]},
         {data: [{:name=>"name", :value=>"cow_2"}]},
         {data: [{:name=>"name", :value=>"cow_3"}]}]
    end

    specify "has links" do
      spider_cows.representation[:collection][:links].should == links
    end

    specify "has href" do
      spider_cows.representation[:collection][:href].should == href
    end
  end


  let(:banana_fish) do
    BananaFish.new legs: 7, eyes: 8, color: "blue"
  end

  let(:banana_fish_2) do
    BananaFish.new legs: 6, face: "red"
  end

  describe ".decorate_item" do
    let(:decorated) do
      BananaFishDecorator.decorate banana_fish do |b|
        b.href "http://example.org/banana_fish/1"
        b.links [{"rel" => "father", "href" => "http://example.com/bananas/tom"},
                 {"rel" => "mother", "href" => "http://example.com/fish/tina"}]
      end

    end

    let(:decorated_2) do
      BananaFishDecorator.decorate banana_fish_2 do |b|
        b.href  "http://example.org/banana_fish/2"
        b.links  [{"rel" =>  "father", "href" => "http://example.com/bananas/tom"}]
      end

    end
    let(:expected) do
      {"collection" =>
       {
         "version" => "1.0",
         "href" => "http://example.org/banana_fish/1",

         "links" => [
           {"rel" => "father", "href" => "http://example.com/bananas/tom"},
           {"rel" => "mother", "href" => "http://example.com/fish/tina"}
       ],

         "items" =>
       [{
         "href"=>"http://example.org/banana_fish/1",
         "data" =>

         [{"name" => "legs", "value" => 7},
          {"name" => "eyes", "value" => 8},
          {"name" => "color", "value" => "blue"}
         ]
       }]}
      }
    end

    let(:expected_2) do
      {"collection" =>
       {
         "version" => "1.0",
         "href" => "http://example.org/banana_fish/2",

         "links" => [
           {"rel" => "father", "href" => "http://example.com/bananas/tom"},
       ],

       "items" =>
       [
         {
         "href"=>"http://example.org/banana_fish/1",
         "data" =>
         [{"name" => "legs",  "value" => 6},
          {"name" => "face", "value" => "red"}
         ]
       }
       ]
       }}
    end

    before do
      decorated_json   = decorated.to_json
      decorated_json_2 = decorated_2.to_json

      @parsed          = JSON.parse(decorated_json  )
      @parsed_2        = JSON.parse(decorated_json_2)
    end

    specify { @parsed.keys.should == expected.keys }
    specify { @parsed.values.should == expected.values }

    %w(version href link items).each do |a|
      specify ", #{a} should match" do
        @parsed[a].should == expected[a]
        @parsed_2[a].should == expected_2[a]
      end
    end
  end

  context "with a block" do
    class CatDecorator
      include CollectionJson::Decorator
    end

    before do
      cat = {legs: 4, tail: true, id: 1}
      attributes = cat.merge({attributes: cat})

      cats = [OpenStruct.new(attributes)]

      decorated = CatDecorator.decorate(cats) do |collection, item|
        collection.links << "/cats"
        collection.href "/cats"
        item.links << "/cats/#{item.id}"
        item.href "/cats/#{item.id}"
      end

      @decorated = JSON[decorated.to_json]["collection"]
    end

    specify { @decorated["links"].should == ["/cats"] }
    specify { @decorated["href"].should == "/cats" }
    specify { @decorated["items"][0]["href"].should == "/cats/1" }
  end

  describe ".decorate_collection" do
    let(:expected_2) do
      {"collection" =>{
        "version" => "1.0",
        "href" => "http://example.org/banana_fish/",

        "links" => [
          {"rel" => "father", "href" => "http://example.com/bananas/tom"},
      ],

      "items" =>
      [
        {"data" =>
         [{"name" => "legs", "value" => 7},
          {"name" => "eyes", "value" => 8},
          {"name" => "color", "value" => "blue"}
         ]
      },

        {"data" =>
         [{"name" => "legs",  "value" => 6},
          {"name" => "face", "value" => "red"}
         ]
      }
      ]
      }
      }
    end
    let(:collection) do
      BananaFishDecorator.decorate_collection [banana_fish, banana_fish_2],
        href: "http://example.org/banana_fish/",
        links: [{"rel" =>  "about", "href" => "http://example.com/about"}]
    end

    let(:parsed) do
      JSON.parse(collection.to_json)
    end

    %w(version href link).each do |a|
      specify ", #{a} should match"do
        parsed["collection"][a].should == expected_2["collection"][a]
      end
    end

  end
end
