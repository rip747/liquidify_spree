module LiquidifySpree
  module Collections
    class AbstractLinkCollection
      def initialize
        @collections = {}
        self.class.subclasses.map{|sc| sc = sc.send(:new)}.each do |links_collection|
          @collections[links_collection.name] = links_collection.collection
        end
      end
      
      def name
        :unknown
      end
      
      def collections
        @collections.stringify_keys
      end
    end
  end
end