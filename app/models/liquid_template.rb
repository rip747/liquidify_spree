class LiquidTemplate < ActiveRecord::Base
  include Extensions::SerializedTemplate
  belongs_to :liquid_theme
end
