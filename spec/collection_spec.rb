class SpiderCowDecorator ;extend CollectionJson::Decorator end

describe CollectionJson::Collection do
  def cow(id) mock 'spider_cow', link: id, attributes: {name: "cow_#{id}"} end

 let(:items) {[cow(1), cow(2), cow(3)]}

  let(:links) {[{rel: "next", href: "spider_cows/?page=3"}] }

  #crazy archaic plural I'd never heard of, cow -> kine. Thanks ActiveSupport
  let(:href) { "/spider_kine" }

  let(:spider_cows) do
    SpiderCowDecorator.decorate items
  end

  describe "#href" do
    specify do
      spider_cows.href "/spider_cows"
      spider_cows.href.should == "/spider_cows"
    end
  end

  describe "#links" do
    specify do
      spider_cows.links           %w(egg banana cheese)
      spider_cows.links.should == %w(egg banana cheese)
    end
  end

  describe "#representation" do
    specify "has items" do
      spider_cows.representation[:collection][:items].should ==
        [{data: [{:name=>"name", :value=>"cow_1"}]},
         {data: [{:name=>"name", :value=>"cow_2"}]},
         {data: [{:name=>"name", :value=>"cow_3"}]}]
    end

    specify "has links" do
      spider_cows.links links
      spider_cows.representation[:collection][:links].should == links
    end

    specify "has href" do
      spider_cows.href href
      spider_cows.representation[:collection][:href].should == href
    end
  end

  let(:banana_fish) do
    BananaFish.new legs: 7, eyes: 8, color: "blue"
  end

  let(:banana_fish_2) do
    BananaFish.new legs: 6, face: "red"
  end

  describe ".decorate_collection" do
    let(:expected_2) do
      {"collection" =>{
        "version" => "1.0",
        "href" => "http://example.org/banana_fish/",

        "links" => [
          {"rel" => "father", "href" => "http://example.com/bananas/tom"},
      ],

      "template" => {"data" =>
                     [{"name"=>"legs",  "value"=>""},
                      {"name"=>"eyes",  "value"=>""},
                      {"name"=>"color", "value"=>""}]
      },
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
      BananaFishDecorator.decorate [banana_fish, banana_fish_2] do |c,i|
        c.href "http://example.org/banana_fish/"

        c.links [ {"rel" => "father", "href" => "http://example.com/bananas/tom"} ]
      end
    end

    let(:parsed) do
      JSON[collection.to_json]
    end

    %w(version href links template).each do |a|
      specify ", #{a} should match"do
        parsed["collection"][a].should == expected_2["collection"][a]
      end
    end
  end
end
