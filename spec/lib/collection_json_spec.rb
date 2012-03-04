# see http://amundsen.com/media-types/collection/format/#link-relations

# example usage:
# class SpiderCowDecorator
#   include CollectionJson
# end
#
# class SpiderCowController
#   def spider_cow_path object
#     "/spider_cows/#{object.id}"
#   end
#
#   def index
#     spider_cows = SpiderCow.all
#
#     @spider_cows = SpiderCowDecorator.new spider_cows,
#       link: ->(i) {spider_cow_path(i)}
#   end
#
#   def show
#     spider_cow = SpiderCow.new params[:id]
#
#     @spider_cow = spider_cow.decorate! link: spider_cow_path(spider_cow)
#   end
# end
#
# class SpiderCow
#   include CollectionJson::Item
#
#   def initialize id
#     @id = id
#   end
# end

describe CollectionJson do
end
