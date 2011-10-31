Deface::Override.new(:virtual_path => "layouts/admin",
                     :name => "themes_admin_tabs",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:liquid_themes, :liquid_templates, :liquid_snippets, :theme_assets) %>",
                     :disabled => false)

 Deface::Override.new(:virtual_path => "admin/shared/_configuration_menu",
                      :name => "add_liquid_themes_settings_tabs",
                      :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
                      :text => %q{<%= configurations_sidebar_menu_item t("liquid_settings"), admin_liquid_settings_path %>},
                      :disabled => false)
                      
Deface::Override.new(:virtual_path => "admin/configurations/index",
                     :name => "add_liquid_themes_settings_to_configuration_menu",
                     :insert_after => "[data-hook='admin_configurations_menu']",
                     :partial => "admin/shared/configurations_menu",
                     :disabled => false)