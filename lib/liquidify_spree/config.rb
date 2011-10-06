module LiquidifySpree
  class Config
    include Singleton
    include Spree::PreferenceAccess

    class << self
      def instance
        return @configuration if @configuration
        return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
        @configuration ||= LiquidifyConfiguration.find_or_create_by_name("Default configuration")
        @configuration
      end

      # searcher_class allows spree extension writers to provide their own Search class
      def searcher_class
        @searcher_class ||= Spree::Search::Base
      end

      def searcher_class=(sclass)
        @searcher_class = sclass
      end

    end
  end
end