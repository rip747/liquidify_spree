ContentController.class_eval do
  include LiquidifyExtender
  liquidify_template :show => 'static_page.liquid'
end