module CollectionJson
  module Interactions
    extend ActiveSupport::Concern

    module ClassMethods
      def create params #POST

      end

      def read id #GET

      end

      def update params #PUT

      end

      def delete id #DELETE

      end

      def query params #GET

      end

      def template #GET

      end

      #Rails style aliases
      def show id #GET
        read id
      end

      def index params #GET
        query params
      end

      def destroy #DELETE
        delete id
      end

      def new #GET
        template
      end

      def edit #GET
        template
      end
    end
  end
end
