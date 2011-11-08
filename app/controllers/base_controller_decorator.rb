Spree::BaseController.class_eval do
  include LiquidifyExtender
  
  def render_page_if_exists
    # If we don't know if page exists we assume it's and we query DB.
    # But we realy don't want to query DB on each page we're sure doesn't exist!
    return if Rails.cache.fetch('page_not_exist/'+request.path)

    if @page = Page.visible.find_by_slug(request.path)

      #load @content object to load correct meta_keywords & meta_description
      @content = @page
      
      #if @page.layout && !@page.layout.empty?
      #  render :template => 'static_content/show', :layout => @page.layout
      #else
      #  render :template => 'static_content/show'
      #end
      render_liquid("content" => LiquidifySpree::PageDrop.new(@page))
    else
      Rails.cache.write('page_not_exist/'+request.path, true)
      return(nil)
    end
  end
end
