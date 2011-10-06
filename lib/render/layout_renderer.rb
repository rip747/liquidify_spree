module LiquidifySpree
  class LayoutRenderer
    attr_reader :parent, :template
    def initialize(liquid_renderer)
      @parent = liquid_renderer
      @template = LiquidifyTemplatesCollection.instance.retrive_theme_template(@parent.theme, nil, :theme)
    end
    
    def render
      @parent.result = @parent.process(@template, {:content_for_layout => @parent.content})
    end
  end
end