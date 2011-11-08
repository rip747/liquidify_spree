OrdersController.class_eval do
  include LiquidifyExtender
  
  liquidify_template :show => 'orders.show.liquid', :edit => 'orders.edit.liquid'
  
  respond_override(
    :show => { :html => { :success => lambda { render_liquid({
      'order' => @order
      }) } } },
    :edit => { :html => { :success => lambda { render_liquid({
      'order' => @order
      }) } } })
end