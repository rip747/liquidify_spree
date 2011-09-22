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
end