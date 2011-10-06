ProductsController.class_eval do
  include LiquidifyExtender
  liquidify_template :index => "products.liquid", :show => "product_item.liquid"
  
  respond_override :index => { :html => { :success => lambda { render_liquid(self, {'products'=>@products}) } } }
end