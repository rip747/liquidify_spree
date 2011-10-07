module LiquidifySpree
  class TaxonDrop < BaseDrop
    liquid_attributes << :name << :taxonomy << :products << :children << :parent
    liquid_methods  << :parent? << :ancestors
  end
end