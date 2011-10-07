OptionValue.class_eval do
  def to_liquid
    LiquidifySpree::OptionValueDrop.new(self)
  end
end