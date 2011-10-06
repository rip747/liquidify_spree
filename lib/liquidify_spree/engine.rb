module LiquidifySpree
  class Engine < Rails::Engine
    engine_name 'liquidify_spree'
    config.autoload_paths += %W(#{config.root}/lib)
    
    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/overrides/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      
      Dir[File.dirname(__FILE__) + '/../liquid/**/*.rb'].each { |f| Rails.env.production? ? require(f) : load(f) }
      
      if Spree::Config.instance
        Spree::Config.set(:default_locale => :ru)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
