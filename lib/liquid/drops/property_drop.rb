module LiquidifySpree
  class PropertyDrop < BaseDrop
    liquid_attributes << :id << :name << :presentation << :prototypes << :product_properties << :products
  end
end