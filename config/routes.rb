Rails.application.routes.draw do
  namespace :admin do
    resources :liquid_themes do
      resources :assets
      resources :snippets
      resources :liquid_templates
    end
  end
end
