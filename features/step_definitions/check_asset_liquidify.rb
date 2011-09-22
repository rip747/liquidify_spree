Given /^assets with filename and template:$/ do |table|
  Asset.create!(table.hashes)
end