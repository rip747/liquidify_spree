module LiquidifySpree
  class TaxonomyDrop < BaseDrop
    liquid_attributes << :name << :root << :parent << :children << :taxons
  end
end

