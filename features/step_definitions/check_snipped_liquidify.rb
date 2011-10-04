Given /^snippet with filename and template:$/ do |table|
  LiquidSnippet.create!(table.hashes)
end

Then /^each snippet must eq this table$/ do |table|
  table.hashes.each do |row|
    LiquidSnippet.find_by_name(row["name"]).liquidify?.to_s.should == row["value"]
  end
end
