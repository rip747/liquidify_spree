Given /^the following themes:$/ do |themes|
  LiquidTheme.create!(themes.hashes)
end

When /^I delete the (\d+)rd theme$/ do |arg1|
  arg1 = arg1.to_i - 1
  LiquidTheme.offset(arg1.to_i).first.destroy
end

Then /^I should have the following themes:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |theme|
    LiquidTheme.find_by_name(theme["name"]).should_not be_nil
  end
end