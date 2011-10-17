Rails.application.routes.draw do
  namespace :admin do
    resources :liquid_themes do
      resources :theme_assets
      resources :liquid_snippets
      resources :liquid_templates
      
    end
    resource :liquid_settings
  end
end
