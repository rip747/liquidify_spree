$:.push File.expand_path("../lib", __FILE__)

require "liquidify_spree/version"

Gem::Specification.new do |s|
  s.name        = "liquidify_spree"
  s.version     = LiquidifySpree::VERSION
  s.authors     = %q{Kirillov Alexander}
  s.email       = %q{saratovsource@gmail.com}
  s.homepage    = "http://geekbox.ru"
  s.summary     = "TODO: Summary of LiquidifySpree."
  s.description = "TODO: Description of LiquidifySpree."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'spree_core', '>= 0.70.0.rc2'
  s.add_dependency "liquid"
  s.add_dependency "haml"
  s.add_dependency "carrierwave"
  s.add_dependency "formtastic"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
end
