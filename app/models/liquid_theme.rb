class LiquidTheme < ActiveRecord::Base
  has_many :liquid_templates
  has_many :theme_assets
  has_many :liquid_snippets
end
