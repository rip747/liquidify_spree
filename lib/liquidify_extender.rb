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
    
    def render_liquid(args={})
      prepare_and_set_response(LiquidifySpree::LiquidThemeRenderer.new({:controller => self}.merge(args)))
    end
    
    def prepare_and_set_response(renderer)
      flash.discard
      response.headers['Content-Type'] = 'text/html; charset=utf-8'
      render :text => renderer.result, :layout => false, :status => :ok
    end
    
  end
end