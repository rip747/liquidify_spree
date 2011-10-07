User.class_eval do
  def to_liquid
    LiquidifySpree::UserDrop.new(self)
  end
end