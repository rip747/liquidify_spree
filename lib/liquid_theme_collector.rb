class LiquidThemeCollector
  attr_reader :liquid_theme, :templates_hash, :options
  
  def initialize(liquid_theme, options = {})
    @liquid_theme = liquid_theme
    @options = options
    @templates_hash = LiquidifyTemplatesCollection.instance.templates_hash
    
    create_missing_templates
  end
  
  def templates
    @liquid_theme.liquid_templates
  end
  
  
  protected
  
  def create_missing_templates
    @templates_hash.each do |clazz, options|
      options.each do |key, value|
        @liquid_theme.liquid_templates.create(:classname => clazz.try(:name), :name=>value) if @liquid_theme.liquid_templates.where(:classname => clazz.try(:name), :name=>value).empty?
      end
    end
  end
end