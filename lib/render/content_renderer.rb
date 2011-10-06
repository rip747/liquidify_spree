module LiquidifySpree
  class ContentRenderer
    attr_reader :parent, :template
    def initialize(liquid_renderer)
      @parent = liquid_renderer
      @template = LiquidifyTemplatesCollection.instance.retrive_theme_template(@parent.theme, @parent.controller, @parent.action)
    end
    
    def render
      @parent.content = @parent.process(@template)
    end
  end
end