require File.expand_path('spec/spec_helper')

class BananaFish < OpenStruct
  def attributes
    @table
  end
end

class BananaFishDecorator
  extend CollectionJson::Decorator

end

describe CollectionJson::Decorator do
  let(:banana_fish) do
    BananaFish.new legs: 7, eyes: 8, color: "blue"
  end

  let(:banana_fish_2) do
    BananaFish.new legs: 6, face: "red"
  end


  describe ".decorate_item" do
    let(:decorated) do
      BananaFishDecorator.decorate_item banana_fish,
        href: "http://example.org/banana_fish/1",
        links: [{"rel" => "father", "href" => "http://example.com/bananas/tom"},
        {"rel" => "mother", "href" => "http://example.com/fish/tina"}]

    end

    let(:decorated_2) do
      BananaFishDecorator.decorate_item banana_fish_2,
        href: "http://example.org/banana_fish/2",
        links: [{"rel" =>  "father", "href" => "http://example.com/bananas/tom"}]

    end
    let(:expected) do
      {
        "version" => "1.0",
        "href" => "http://example.org/banana_fish/1",

        "links" => [
          {"rel" => "father", "href" => "http://example.com/bananas/tom"},
          {"rel" => "mother", "href" => "http://example.com/fish/tina"}
        ],

        "items" =>
          [{"data" =>
            [{"name" => "legs", "value" => 7},
             {"name" => "eyes", "value" => 8},
             {"name" => "color", "value" => "blue"}
            ]
      }]}
    end

    let(:expected_2) do
      {
        "version" => "1.0",
        "href" => "http://example.org/banana_fish/2",

        "links" => [
          {"rel" => "father", "href" => "http://example.com/bananas/tom"},
        ],

        "items" =>
          [
            {"data" =>
              [{"name" => "legs",  "value" => 6},
               {"name" => "face", "value" => "red"}
              ]
            }
          ]
      }
    end

    before do
      decorated_json = decorated.to_json
      decorated_json_2 = decorated_2.to_json
      @parsed = JSON.parse(decorated_json)
      @parsed_2 = JSON.parse(decorated_json_2)
    end

    %w([version href link items).each do |a|
      specify ", #{a} should match"do
        @parsed[a].  should == expected[a]
        @parsed_2[a].should == expected_2[a]
      end
    end
  end

  describe ".decorate_collection" do
    let(:expected_2) do
      {
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
    end
    let(:collection) do
      BananaFishDecorator.decorate_collection [banana_fish, banana_fish_2],
        href: "http://example.org/banana_fish/",
        links: [{"rel" =>  "about", "href" => "http://example.com/about"}]
    end

    let(:parsed) do
      JSON.parse(collection.to_json)
    end

    %w([version href link).each do |a|
      specify ", #{a} should match"do
        parsed[a].should == expected_2[a]
      end
    end

  end
end
