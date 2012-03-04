class SpiderCowDecorator
  include CollectionJson::Decorator
  attr_accessor :id

end

class SpiderCowController
  def spider_cow_path object
    "/spider_cows/#{object.id}"
  end

  def index
    spider_cows = SpiderCow.all

    @spider_cows = SpiderCowDecorator.decorate spider_cows

    link_generator = ->(i){[{href: spider_cow_path(i), rel: "show"}]}
    @spider_cows.item_links_lambda = link_generator
  end

  def show
    spider_cow = SpiderCow.new params[:id]

    @spider_cow = SpiderCowDecorator.decorate spider_cow,
      link: spider_cow_path(spider_cow)
  end
end

class SpiderCow
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


