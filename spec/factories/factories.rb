# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  [:theme_asset, :liquid_theme].each do |inst|
    factory inst do
    end
  end
end