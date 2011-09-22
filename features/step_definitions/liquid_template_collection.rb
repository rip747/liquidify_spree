# Implement only one class of singleton
Given /^singleton named LiquidifyTemplatesCollection$/ do
  @tc = LiquidifyTemplatesCollection.instance
  @tc.should_not be_nil
end

When /^I add any template to collection$/ do
  @tc.register("SomeClass", {:index => "test.liquid"})
end

Then /^I must see one instance of collection with hash of templates$/ do
  @tc_second = LiquidifyTemplatesCollection.instance
  @tc.should == @tc_second
  ObjectSpace.each_object(LiquidifyTemplatesCollection){}.should == 1
end

# Extend Array class with LiquidifyExtender mixin
Given /^class with included LiquidifyExtender module$/ do
  Array.send(:include, LiquidifyExtender)
  #Array.method_defined?(:liquidify_template).should == true
end

When /^register any actions with templates for this class$/ do
  Array.liquidify_template(:to_s => "to_s.liquid")
  ["test array"].liquidify_template(:flatten => "flatten.liquid")
end

When /^dublicate call registration action for one class$/ do
  Array.liquidify_template(:to_s => "to_string.liquid")
end

Then /^liauid collection must have this hash$/ do
  LiquidifyTemplatesCollection.instance.templates_hash[Array].should_not be_nil
  {:to_s => "to_string.liquid", :flatten => "flatten.liquid"}.each do |key, value|
    LiquidifyTemplatesCollection.instance.templates_hash[Array][key].should == value
  end
end

Then /^each class in collection must have only one last template to any action$/ do
  LiquidifyTemplatesCollection.instance.templates_hash[Array].keys.count.should == 2
end