module CollectionJson::Decorator
  def decorate object
    klass = object.respond_to?(:each) ? CollectionJson::Collection : CollectionJson::Item

    klass.new(object).tap do |o|
      if object.respond_to? :each
        o.items.each { |i| yield o, i } if block_given?
      else
        yield o if block_given?
      end
    end
  end
end
