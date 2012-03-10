require './spec/support/sample_mvc'

describe "CollectionJson", type: :integration do
  let(:controller) { SpiderCowController.new      }

  describe "controller#index" do
    before do
      controller.index
      @spider_cows = controller.instance_eval{@spider_cows}
    end

    it "assigns a collection with items" do
      items = @spider_cows.items
      items.should be_a Enumerable

      items.each do |x|
        x.should be_a CollectionJson::Item
      end
    end

    it "defines the link using a lambda" do
      items = @spider_cows.items
      item = items.first

      item.item_links.should == [{href: "/spider_cows/1", rel: "self"}]
    end
  end
end
