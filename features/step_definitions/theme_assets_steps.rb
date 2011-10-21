#@asset = Factory(:theme_asset, {:source => @file, :liquid_theme => @theme})
#@asset.content_type.should equal(content_type.to_sym)

Given /^I have the theme: "([^"]*)" set up$/ do |theme_name|
  @theme = Factory(:liquid_theme, :name => theme_name)
  @files = []
end

Given /^a files$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |row|
    file = row["file"]
    @files << {:name => file, :file => File.open(File.join(File.dirname(__FILE__), '../../test/fixtures', file))} 
  end
end

When /^I create new ThemeAssets item from this files$/ do
  @files.map{|row| row[:content] = Factory(:theme_asset, {:source => row[:file], :liquid_theme => @theme})}
end

Then /^files must eq with their content_types$/ do |table|
  @files.each_with_index { |item, index| p table.hashes[index]["content_type"].should eq(item[:content].content_type.to_s) }
end
