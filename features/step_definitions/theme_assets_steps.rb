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

Given /^any planar text$/ do
  @text = "alert('hello')"
end

Given /^Default theme must have no one any theme asset$/ do
  ThemeAsset.where(:liquid_theme_id => @theme.id).destroy_all
end


When /^I create a "([^"]*)" file with "([^"]*)" type$/ do |file_name, file_type|
  @test_planar_asset = Factory(:theme_asset, {
      :plain_text_name => file_name,
      :plain_text => @text,
      :plain_text_type => file_type,
      :performing_plain_text => true,
      :liquid_theme => @theme
    }
  )
end

Then /^I must have a file in default theme with name "([^"]*)" and type "([^"]*)"$/ do |file_name, file_type|
  @test_planar_file = @theme.theme_assets.first
  @test_planar_file.source.file.filename.should eq(file_name)
  @test_planar_file.content_type.should eq(file_type)
end

Then /^source of this file must be not empty$/ do
  @test_planar_file.source.should_not be_nil
end

Then /^content of this file must be as given planar text$/ do
  @test_planar_file.source.file.read.should eq(@text)
end

