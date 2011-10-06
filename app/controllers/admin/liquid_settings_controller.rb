class Admin::LiquidSettingsController < Admin::BaseController
  before_filter :define_preferences, :only => [:show, :edit]
  
  def show
    
  end

  def edit
    
  end

  def update
    @config = LiquidifySpree::Config.instance
    @config.update_attributes(params[@config.class.name.underscore])
    Rails.cache.delete("configuration_#{@config.class.name}".to_sym)
    redirect_to admin_liquid_settings_path
  end
  
  protected
  
  def define_preferences
    @preferences = %w{theme}
    return true
  end
end