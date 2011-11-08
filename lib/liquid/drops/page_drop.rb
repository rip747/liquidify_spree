module LiquidifySpree
  class PageDrop < BaseDrop
    liquid_attributes.push(*[:id, :title, :slug, :body, :link])
  end
end