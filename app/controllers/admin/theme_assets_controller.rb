class Admin::ThemeAssetsController < Admin::ResourceController
  belongs_to :liquid_theme
  before_filter :set_content_type_to_planar, :only => [:new]
  
  def location_after_save
    edit_admin_liquid_theme_path(@parent)
  end
  
  private
  
  def set_content_type_to_planar
    @theme_asset.performing_plain_text = !params[:content_type].blank?
    @theme_asset.plain_text_type = %w{javascript, stylesheet}.include?(params[:content_type]) ? params[:content_type] : "stylesheet"
  end
end