module LiquidifySpree
  class LiquidThemeRenderer
    attr_accessor :controller, :action, :theme, :content, :header, :result
    attr_accessor :args, :registers
    def initialize(args = {})
      @args = {}
      unless args.blank?
        @controller = args.delete(:controller)
        @action = args.delete(:action) || @controller.params[:action]
        @args = default_params_to_liquid.merge(args)
      end
      @theme = retrive_active_theme(args.delete(:theme))
      @registers = {
        :theme => @theme
      }
      
      render
    end
    
    def render
      ContentRenderer.new(self).render
      LayoutRenderer.new(self).render
    end
    
    def process(liquid_template, assigns = {})
      return "" if liquid_template.nil?
      liquid_template.render(context(@args.merge(assigns).stringify_keys))
    end
    
    def process_text_template(template, assigns = {})
     liquid_template = ::Liquid::Template.parse(template)
     process(liquid_template, assigns)
    end
    
    protected
    
    def context(assigns)
      ::Liquid::Context.new({}, assigns, @registers)
    end
    
    def retrive_active_theme(name = nil)
      LiquidTheme.find_by_name(name || LiquidifySpree::Config[:theme] || "Default")
    end
    
    def default_params_to_liquid
      ret = {}
      #configurations
      ret[:config] ||= {}
      %w{site_name default_meta_description default_meta_keywords site_url logo}.each do |key|
        ret[:config][key] = Spree::Config[key.to_sym]
      end
      
      #retrive cart
      ret[:cart] ||= @controller.current_order(true)
      
      ret.stringify_keys
    end
  end
end