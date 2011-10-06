module LiquidifySpree
  class LiquidThemeRenderer
    attr_accessor :controller, :action, :theme, :content, :header, :result
    attr_accessor :args
    def initialize(args = {})
      @controller = args.delete(:controller)
      @action = args.delete(:action) || @controller.params[:action]
      @theme = retrive_active_theme(args.delete(:theme))
      @args = default_params_to_liquid.merge(args)
      
      render
    end
    
    def render
      ContentRenderer.new(self).render
      LayoutRenderer.new(self).render
    end
    
    def process(liquid_template, assigns = {})
      return "" if liquid_template.nil?
      liquid_template.render(@args.merge(assigns).stringify_keys)
    end
    
    protected
    
    def retrive_active_theme(name)
      LiquidTheme.find_by_name(name || LiquidifySpree::Config[:theme])
    end
    
    def default_params_to_liquid
      ret = {}
      #configurations
      ret[:config] ||= {}
      %w{site_name default_meta_description default_meta_keywords site_url logo}.each do |key|
        ret[:config][key] = Spree::Config[key.to_sym]
      end
      
      ret.stringify_keys
    end
  end
end