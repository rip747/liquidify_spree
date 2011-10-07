module LiquidifySpree
  class OrderDrop < BaseDrop

    liquid_attributes << :line_items << :bill_address_attributes << :ship_address_attributes << :payments_attributes << :user << :number << :item_total << :total << :state << :adjustment_total << :credit_total << :bill_address << :ship_address << :payment_total << :shipping_method << :shipment_state << :payment_state << :email << :special_instructions #<< :line_items_attributes

  end
end