module LiquidifySpree
  module Collections
    class PagesCollection < AbstractLinkCollection
      attr_accessor :pages
      
      def initialize
        @pages = {
          :header => ::Page.header_links.map{|hl| hl = LiquidifySpree::PageDrop.new(hl)},
          :footer => ::Page.footer_links.map{|hl| hl = LiquidifySpree::PageDrop.new(hl)},
          :sidebar => ::Page.sidebar_links.map{|hl| hl = LiquidifySpree::PageDrop.new(hl)}
        }
      end
      
      def name
        :pages
      end
      
      def collection
        @pages.stringify_keys
      end
    end
  end
end