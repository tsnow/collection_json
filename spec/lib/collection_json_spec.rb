require File.expand_path('spec/spec_helper')

class HerdOfSpiderCows
  include CollectionJson
  extend CollectionJson::CrudOperations
  extend CollectionJson::Query

  def initialize items, links=[], queries=[], template={}
    @items, @links, @queries, @template = items, links, queries, template
  end
end

#see http://amundsen.com/media-types/collection/format/#link-relations
describe CollectionJson do
  let(:spider_cows) { HerdOfSpiderCows.new [1,2,3],
                      ['/spider_cow/1', '/spider_cow/2', 'spider_cow/3'] }


  describe "#href" do
    specify {spider_cows.href.should == "/herd_of_spider_cows" }

    specify do
      spider_cows.href= "/gathering_of_spider_cows"
      spider_cows.href.should == "/gathering_of_spider_cows"
    end
  end

  describe "#links" do
   specify "has links" do
      spider_cows.links.should ==
        ['/spider_cow/1', '/spider_cow/2', 'spider_cow/3']
    end

   specify do
     spider_cows.links = %w[egg banana cheese]
     spider_cows.links.should == %w[egg banana cheese]
   end
  end

  describe "#collection" do
    specify do
      spider_cows.collection.should be_a Hash
    end

    specify "has items" do
      spider_cows.collection[:items].should == [1,2,3]
    end

    specify "has links" do
      spider_cows.collection[:links].should ==
        ['/spider_cow/1', '/spider_cow/2', 'spider_cow/3']
    end
  end
end
