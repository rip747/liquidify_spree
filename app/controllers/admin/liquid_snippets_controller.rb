class Admin::LiquidSnippetsController < Admin::ResourceController
  belongs_to :liquid_theme
  
  def location_after_save
    edit_admin_liquid_theme_path(@parent)
  end
end