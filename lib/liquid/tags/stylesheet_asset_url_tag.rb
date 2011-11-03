module LiquidifySpree
  module Liquid
    module Tags
      class StylesheetAssetUrlTag < ::Liquid::Tag
        attr_accessor :theme
        Syntax = /(#{::Liquid::Expression}+)?/
        AssetType = :stylesheet
        
        def initialize(tag_name, markup, tokens)
          if markup =~ Syntax
            @file_name = $1.gsub('\'', '')
            @theme = LiquidTheme.find_by_name("Default")
          else
            raise ::Liquid::SyntaxError.new("Syntax Error in 'stylesheet_asset_url' - Valid syntax: stylesheet_asset_url <stylesheet_name>")
          end
          super
        end
        
        def render(context)
          return if (@theme.blank? || @file_name.blank?)
          retrive_file_path
        end
        
        def retrive_file_path
          file = @theme.theme_assets.where(:content_type => AssetType, :local_path => @file_name).first
          return "" if file.blank?
          "#{file.source.url}"
        end
      end
      ::Liquid::Template.register_tag('theme_asset_url', StylesheetAssetUrlTag)
    end
  end
end