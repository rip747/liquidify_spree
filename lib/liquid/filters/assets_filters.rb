module LiquidifySpree
  module Liquid
    module Filters
      module AssetsFilters
        # Write the url to a stylesheet resource
        # input: name of the css file
        def stylesheet_url_old(input)
          return '' if input.nil?
          unless input =~ /^(\/|https?:)/
            input = asset_url("stylesheets/#{input}")
          end
          input = "#{input}.css" unless input.to_s =~ /.css$/
          input
        end
        
        def stylesheet_url(input)
          asset_url_with_types(input, :css)
        end
        
        def asset_url(path)
          ThemeAssetUploader.url_for(@context.registers[:theme], path)
        end
        
        private
        
        def asset_url_with_types(input, type)
          return '' if input.nil?
          unless input =~ /^(\/|https?:)/
            input = asset_url("stylesheets/#{input}")
          end
          input = "#{input}.#{type}" unless input.to_s =~ /.#{type}$/
          input
        end
      end
      ::Liquid::Template.register_filter(AssetsFilters)
    end
  end
end