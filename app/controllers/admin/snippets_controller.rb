class Admin::SnippetsController < Admin::ResourceController
  belongs_to :liquid_theme
end