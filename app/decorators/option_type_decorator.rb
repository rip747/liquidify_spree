OptionType.class_eval do
  def to_liquid
    LiquidifySpree::OptionTypeDrop.new(self)
  end
end