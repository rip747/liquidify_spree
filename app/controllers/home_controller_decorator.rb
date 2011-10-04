HomeController.class_eval do
  include LiquidifyExtender
  
  liquidify_template :index => 'home.liquid'
end