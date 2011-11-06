module LiquidifySpree
  module Liquid
    module Filters
      module AssetsFilters
        # Write the url to a stylesheet resource
        # input: name of the css file
        def stylesheet_url(input)
          asset_url_with_types(input, :css, "stylesheets")
        end
        
        # Write the link to a stylesheet resource
        # input: url of the css file
        def stylesheet_tag(input, media = 'screen')
          return '' if input.nil?

          input = stylesheet_url(input)

          %{<link href="#{input}" media="#{media}" rel="stylesheet" type="text/css" />}
        end
        
        def javascript_url(input)
          asset_url_with_types(input, :js, "javascripts")
        end
        
        # Write the link to javascript resource
        # input: url of the javascript file
        def javascript_tag(input)
          return '' if input.nil?

          input = javascript_url(input)

          %{<script src="#{input}" type="text/javascript"></script>}
        end
        
        # Write a theme image tag
        # input: name of file including folder
        # example: 'about/myphoto.jpg' | theme_image # <img src="images/about/myphoto.jpg" />
        def theme_image_tag(input, *args)
          image_options = inline_options(args_to_options(args))

          "<img src=\"#{theme_image_url(input)}\" #{image_options}/>"
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
        
        protected
        
        # Convert an array of properties ('key:value') into a hash
        # Ex: ['width:50', 'height:100'] => { :width => '50', :height => '100' }
        def args_to_options(*args)
          options = {}
          args.flatten.each do |a|
            if (a =~ /^(.*):(.*)$/)
              options[$1.to_sym] = $2
            end
          end
          options
        end
        
        # Write options (Hash) into a string according to the following pattern:
        # <key1>="<value1>", <key2>="<value2", ...etc
        def inline_options(options = {})
          return '' if options.empty?
          (options.stringify_keys.sort.to_a.collect { |a, b| "#{a}=\"#{b}\"" }).join(' ') << ' '
        end
      end
      ::Liquid::Template.register_filter(AssetsFilters)
    end
  end
end