class Admin::ThemeAssetsController < Admin::ResourceController
  belongs_to :liquid_theme
  before_filter :set_content_type_to_planar, :only => [:new]
  
  def location_after_save
    edit_admin_liquid_theme_path(@parent)
  end
  
  private
  
  def set_content_type_to_planar
    @theme_asset.performing_plain_text = true
    @theme_asset.plain_text_type = %w{javascript, stylesheet}.select{ | p | p = params[:content_type]}
  end
end