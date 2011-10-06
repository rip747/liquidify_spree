require 'liquid'
require 'spree_core'
require "liquidify_extender"
require "liquidify_templates_collection"
require "liquidify_spree/config"
require "liquidify_spree/engine"

module LiquidifySpree
  # The path the default liquid templates are stored.
  mattr_accessor :template_paths
  self.template_paths = []
  
  # Module for drops. When instance variable is passed to a template, it's wrapped with a drop.
  # This is a module the drops are looked up. If nil, the drops are looked up in the global
  # namespace.
  mattr_accessor :drop_module

  if defined?(Rails)
    #self.template_paths << "#{Rails.root}/db/liquid_templates"
  end
end
