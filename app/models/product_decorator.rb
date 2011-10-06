Product.class_eval do
  def to_liquid
    LiquidifySpree::ProductDrop.new(self)
  end
end