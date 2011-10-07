Variant.class_eval do
  def to_liquid
    LiquidifySpree::VariantDrop.new(self)
  end
end