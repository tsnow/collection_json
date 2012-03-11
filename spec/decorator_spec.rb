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
  context "with a block" do
    class CatDecorator
      extend CollectionJson::Decorator
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
end
