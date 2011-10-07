Taxon.class_eval do
  def to_liquid
    LiquidifySpree::TaxonDrop.new(self)
  end
end