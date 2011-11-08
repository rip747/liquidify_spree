Dir[File.dirname(__FILE__) + '/collections/*.rb'].each { |f| Rails.env.production? ? require(f) : load(f) }

module LiquidifySpree
  module Collections
    
  end
end