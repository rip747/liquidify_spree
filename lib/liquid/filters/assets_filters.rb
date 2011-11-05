module LiquidifySpree
  module Liquid
    module Filters
      module AssetsFilters
        # Write the url to a stylesheet resource
        # input: name of the css file
        def stylesheet_url(input)
          asset_url_with_types(input, :css, "stylesheets")
        end
        
        def javascript_url(input)
          asset_url_with_types(input, :js, "javascripts")
        end
        
        def theme_image_url(input)
          return '' if input.nil?
          input = "images/#{input}"
          asset_url(input)
        end
        
        def asset_url(path)
          ThemeAssetUploader.url_for(@context.registers[:theme], path)
        end
        
        private
        
        def asset_url_with_types(input, type, path)
          return '' if input.nil?
          unless input =~ /^(\/|https?:)/
            input = asset_url("#{path}/#{input}")
          end
          input = "#{input}.#{type}" unless input.to_s =~ /.#{type}$/
          input
        end
      end
      ::Liquid::Template.register_filter(AssetsFilters)
    end
  end
end