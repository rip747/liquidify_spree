ProductProperty.class_eval do
  def to_liquid
    LiquidifySpree::ProductPropertyDrop.new(self)
  end
end