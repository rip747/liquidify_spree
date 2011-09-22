Given /^the following themes:$/ do |themes|
  Theme.create!(themes.hashes)
end

When /^I delete the (\d+)rd theme$/ do |arg1|
  arg1 = arg1.to_i - 1
  Theme.offset(arg1.to_i).first.destroy
end

Then /^I should have the following themes:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |theme|
    Theme.where(:name => theme["name"]).first.should_not be_nil
  end
end