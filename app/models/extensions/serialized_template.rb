module Extensions
  module SerializedTemplate
    extend ActiveSupport::Concern
    
    included do
      before_validation :serialize_item_template
      validate :item_template_must_be_valid
    end
          
    module InstanceMethods
      def item_template
        begin
          @item_template ||= self.liquidify? ? Marshal.load(ActiveSupport::Base64.decode64(read_attribute(:serialized_item_template))) : self.raw_item_template
        rescue Exception => e
          nil
        end
      end
      
      def liquidify?
        File.extname(self.name) == ".liquid"
      end
      
      protected
      
      def serialize_item_template
        if self.new_record? || self.raw_item_template_changed?
          @item_parsing_errors = []
          begin
            self._parse_and_serialize_item_template
          rescue ::Liquid::SyntaxError => error
            @item_parsing_errors << I18n.t(:liquid_syntax, :error => error.to_s, :scope => [:errors, :messages])
          end
        end
      end
      
      def _parse_and_serialize_item_template
        item_template = ::Liquid::Template.parse(self.raw_item_template)
        self.serialized_item_template = ActiveSupport::Base64.encode64(Marshal.dump(item_template))
      end
      
      def item_template_must_be_valid
        @item_parsing_errors.try(:each) { |msg| self.errors.add :item_template, msg }
      end
    end
    
  end
end