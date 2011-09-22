Given /^the following templates:$/ do |templates|
  Template.create!(templates.hashes)
end

Given /^values hash:$/ do |table|
  @temp_values = table.hashes
end

When /^I render templates$/ do
  @rendering_templates = {}
  @temp_values.each do |h|
    template = Template.where(:name => h["name"]).first
    @rendering_templates[h["name"]] = template.liquidify? ? template.item_template.render(h) : template.item_template
  end
end

Then /^All templates must be liquidify$/ do
  Template.all.each do |template|
    template.liquidify?.should be_true
  end
end

Then /^I must have template eq result$/ do
  @temp_values.each do |h|
    @rendering_templates[h["name"]].should eq(h["result"])
  end
end
