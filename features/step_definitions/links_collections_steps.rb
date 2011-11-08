Given /^abstract link collection$/ do
  @link_collection = LiquidifySpree::Collections::AbstractLinkCollection.new
end

When /^I send "([^"]*)" method to abstract collection$/ do |method|
  @collections = @link_collection.send(method)
end

Then /^I mush have many collections$/ do
  p @collections
end

Given /^site with any sets of page$/ do
  pending # express the regexp above with the code you wish you had
end

When /^retrive links collections$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I must have many links of pages$/ do
  pending # express the regexp above with the code you wish you had
end
