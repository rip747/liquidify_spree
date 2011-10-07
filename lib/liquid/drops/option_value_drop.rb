module LiquidifySpree
  class OptionValueDrop < BaseDrop

    liquid_attributes << :name << :option_type << :position << :presentation << :variants

  end
end