module Extensions
  module PlainStore
    extend ActiveSupport::Concern
    included do
      attr_accessor :plain_text_name, :plain_text, :plain_text_type, :performing_plain_text
      
      before_validation :store_plain_text
      
      validates_presence_of :plain_text_name, :if => Proc.new { |a| a.performing_plain_text? }
      validates_uniqueness_of :local_path, :scope => :liquid_theme_id
    end

    module ClassMethods
      
    end

    module InstanceMethods
      
      def plain_text_name
        if not @plain_text_name_changed
          @plain_text_name ||= self.safe_source_filename
        end
        @plain_text_name.gsub(/(\.[a-z0-9A-Z]+)$/, '') rescue nil
      end
      
      def plain_text_name=(name)
        @plain_text_name_changed = true
        @plain_text_name = name
      end

      def plain_text
        if RUBY_VERSION =~ /1\.9/
          @plain_text ||= (self.source.read.force_encoding('UTF-8') rescue nil)
        else
          @plain_text ||= self.source.read
        end
      end

      def plain_text_type
        @plain_text_type || (stylesheet_or_javascript? ? self.content_type : nil)
      end

      def performing_plain_text?
        self.performing_plain_text || false
      end
      
      def store_plain_text
        self.content_type ||= @plain_text_type if self.performing_plain_text?
        
        data = self.performing_plain_text? ? self.plain_text : self.source.read
      
        return if !self.stylesheet_or_javascript? || self.plain_text_name.blank? || data.blank?
      
        sanitized_source = self.escape_shortcut_urls(data)
        
        san_file_name = "#{self.plain_text_name}.#{self.stylesheet? ? 'css' : 'js'}"
      
        self.source = CarrierWave::SanitizedFile.new({
          :tempfile => ::StringIO.new(sanitized_source),
          :filename => san_file_name,
          :content_type => MIME::Types.type_for(san_file_name).first.content_type
        })
        
      end
      
      def escape_shortcut_urls(text)
        return if text.blank?

        text.gsub(/[("'](\/(stylesheets|javascripts|images|medias)\/(([^;.]+)\/)*([a-z_\-0-9]+)\.[a-z]{2,3})[)"']/) do |path|

          sanitized_path = path.gsub(/[("')]/, '').gsub(/^\//, '')

          if asset = self.liquid_theme.theme_assets.where(:local_path => sanitized_path).first
            "#{path.first}#{asset.source.url}#{path.last}"
          else
            path
          end
        end
      end
      
    end
  end
end