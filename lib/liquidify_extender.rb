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
    
    def render_liquid(controller, args={})
      @output = ""
      @action = args[:action] || controller.params[:action]
      @template_name = LiquidifyTemplatesCollection.instance.retrive_template_name(controller, @action)
      unless @template_name.empty?
        @theme = retrive_liquid_theme(args.delete(:theme))
        prepare_and_set_response(@output) and return if @theme.nil?
        @template = @theme.liquid_templates.where(:name => @template_name).first
        @template = @template.try(:item_template)
        unless (@template.nil?)
          begin
            args = {}.
            merge(args).
            merge(default_params_to_liquid)
            @output = @template.render(args.stringify_keys)
          rescue Exception => e
            @output = e.message
          end
        end
      end
      prepare_and_set_response(@output)
    end
    
    def prepare_and_set_response(output)
      flash.discard
      response.headers['Content-Type'] = 'text/html; charset=utf-8'
      render :text => output, :layout => false, :status => :ok
    end
    
    protected
    
    def retrive_liquid_theme(theme_name)
      LiquidTheme.find_by_name(theme_name || LiquidifySpree::Config[:theme])
    end
    
    def default_params_to_liquid
      ret = {}
      #configurations
      ret[:config] ||= {}
      %w{site_name default_meta_description default_meta_keywords site_url logo}.each do |key|
        ret[:config][key] = Spree::Config[key.to_sym]
      end
      
      ret.stringify_keys
    end
    
  end
end