class LiquidifyTemplatesCollection
  include Singleton
  
  attr_accessor :templates_hash
  
  def initialize
    @templates_hash ||= {}
  end
  
  
  # klass: Class of register object, args - {:action => template_name }
  # example:
  # register HomeController => {:index => "index.liquid", :show => "index.liquid", :complete => "complete.liquid"}
  def register(klass = nil, args = Hash.new)
    return if klass.nil? or args.blank?
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
      return ""
    end
  end
end