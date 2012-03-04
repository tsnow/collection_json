class SpiderCowController
  def index
    spider_cows = SpiderCow.all

    @spider_cows = SpiderCowDecorator.decorate(spider_cows) do |s|
      s.item_links [{href: spider_cow_path(s), rel: "self"}]
      s
    end
  end

  #in real life this method will be made available
  #rather than defined here
  def spider_cow_path object
    "/spider_cows/#{object.id}"
  end
end

class SpiderCow
  attr_accessor :id

  def self.all
    [SpiderCow.new(1), SpiderCow.new(2), SpiderCow.new(3)]
  end

  def attributes
    {id: @id}
  end

  def initialize id
    @id = id
  end
end


class SpiderCowDecorator
  include CollectionJson::Decorator
  attr_accessor :id
end


