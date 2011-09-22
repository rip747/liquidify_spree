module LiquidifyExtender
  extend ActiveSupport::Concern
  
  module ClassMethods
    #add actions of extended class to collection
    def liquidify_template(args = Hash.new)
      return if args.blank?      
      LiquidifyTemplatesCollection.instance.register(self, args)
    end
  end
  
  module InstanceMethods
    def liquidify_template(args = Hash.new)
      self.class.liquidify_template(args)
    end
  end
end