Taxonomy.class_eval do
  def to_liquid
    LiquidifySpree::TaxonomyDrop.new(self)  
  end
end