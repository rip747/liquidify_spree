Order.class_eval do
  def to_liquid
    LiquidifySpree::OrderDrop.new(self)
  end
    
  def special_instructions
    @special_instructions
  end
  
  def use_billing
    @use_billing
  end
  
  def shipping_method_id
    @shipping_method_id
  end
  
  def email
    @email
  end
  
  def line_items_attributes
    @line_items_attributes
  end
  
  def ship_address
    @ship_address
  end
  
  def payments_attributes
    @payments_attributes
  end
  
  def ship_address_attributes
    @ship_address_attributes
  end
  
  def line_items
    @line_items
  end
  
  def bill_address_attributes
    @bill_address_attributes
  end
end