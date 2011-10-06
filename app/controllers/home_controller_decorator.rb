HomeController.class_eval do
  include LiquidifyExtender
  respond_to :html
  
  liquidify_template :index => 'home.liquid'
  
  def index
    @searcher = Spree::Config.searcher_class.new(params)
    @products = @searcher.retrieve_products
    render_liquid(self, {'products'=>@products})
  end
end