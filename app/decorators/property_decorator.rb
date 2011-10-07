Property.class_eval do
  def to_liquid
    LiquidifySpree::PropertyDrop.new(self)
  end
end