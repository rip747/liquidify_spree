Deface::Override.new(:virtual_path => "layouts/admin",
                     :name => "themes_admin_tabs",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:liquid_themes) %>",
                     :disabled => false)