Given /^I have the theme: "([^"]*)" set up$/ do |theme_name|
  @theme = Factory(:liquid_theme, :name => theme_name)
end

Given /^a stylesheet file named "([^"]*)"$/ do |filename|
  @file = File.open(File.join(File.dirname(__FILE__), '../../test/fixtures', filename))
end

When /^I create new ThemeAsset item from this file$/ do
  @asset = Factory(:theme_asset, {:source => @file, :liquid_theme => @theme})
end

Then /^file must have content_type "([^"]*)"$/ do |content_type|
  @asset.content_type.should equal(content_type.to_sym)
end
