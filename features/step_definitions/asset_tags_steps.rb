Given /^asset named "([^"]*)"$/ do |filename|
  @file = Factory(:theme_asset, {:source => File.open(File.join(File.dirname(__FILE__), '../../test/fixtures', filename)), :liquid_theme => @theme})
end

When /^I render liquid template with "([^"]*)"$/ do |template_string|
  @result = LiquidifySpree::LiquidThemeRenderer.new().process_text_template(template_string)
end

Then /^must get a "([^"]*)"$/ do |styleheet_path|
  @result.should eq(styleheet_path)
end
