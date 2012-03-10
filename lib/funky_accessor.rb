module FunkyAccessor
  def self.extended base
    class << base
      def funky_accessor *names
        names.each do |name|
          define_method(name) do |arg=nil|
            if block_given?
              instance_variable_set(:"@#{name}", yield)
            elsif arg
              instance_variable_set(:"@#{name}", arg)
            else
              instance_variable_get(:"@#{name}")
            end
          end
        end
      end
    end
  end
end
