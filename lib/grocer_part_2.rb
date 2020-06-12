require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  coupons.each do |element|
    cart_item = find_item_by_name_in_collection(element[:item], cart)
    couponed_item_name = "#{element[:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= element[:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += element[:num]
        cart_item[:count] -= element[:num]
        
      else 
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => element[:cost] / element[:num],
          :count => element[:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= element[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |element|
    if element[:clearance]
      element[:price] = (element[:price] - element[:price] * 0.20).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  final_cart.each do |element|
    total += element[:price] * element[:count]
  end 
  if total > 100 
    total -= (total * 0.10)
  end
  total
end
