class LiquidifyTemplatesCollection
  include Singleton
  
  attr_accessor :templates_hash
  
  def initialize
    @templates_hash ||= {}
    register(nil.class, {:theme => "Theme.liquid", :not_found => "404.liquid"})
  end
  
  
  # klass: Class of register object, args - {:action => template_name }
  # example:
  # register HomeController => {:index => "index.liquid", :show => "index.liquid", :complete => "complete.liquid"}
  def register(klass, args = Hash.new)
    return if args.blank?
    @templates_hash[klass] ||= {}
    @templates_hash[klass].merge!(args)
  end
  
  def templates_hash
    @templates_hash
  end
  
  def retrive_template_name(controller, action)
    begin
      return @templates_hash[controller.class][action.to_sym]
    rescue Exception => e
      p e
      return ""
    end
  end
  
  def retrive_theme_template(theme, controller, action)
    template_name = retrive_template_name(controller, action)
    template = theme.liquid_templates.where(:name => template_name).first
    return template.try(:item_template)
  end
end