class BananaFish < OpenStruct
  def attributes
    @table
  end
end

class BananaFishDecorator
  extend CollectionJson::Decorator
end


describe CollectionJson::Item do
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
           {"rel" => "mother", "href" => "http://example.com/fish/tina"}],

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

end
