TaxonsController.class_eval do
  include LiquidifyExtender
  
  liquidify_template :show => 'taxons.liquid'
  respond_override :show => { :html => { :success => lambda { render_liquid({
    'taxon' => @taxon,
    'products' => @products
    }) } } }
end