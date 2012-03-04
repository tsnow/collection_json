module CollectionJson::Item
  def self.included base
    base.class_eval do
      include Virtus

      def link #used in a singular item
        @link ||= "/" + self.class.to_s.gsub(/Decorator$/, "").
          underscore + "/" + @id.to_s
      end

    end
  end
end
