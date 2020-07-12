require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
 cart.each { |cart_item|
  
    coupons.each { |coupon_item|
      if cart_item[:item] == coupon_item[:item] && cart_item[:count] >= coupon_item[:num]
        discount_price = coupon_item[:cost] / coupon_item[:num]
        
        if cart_item[:count] % coupon_item[:num] == 0
          cart_item[:item] = cart_item[:item] + " W/COUPON"
          cart_item[:price] = discount_price
          
        else
          remaining = cart_item[:count] % coupon_item[:num]
          cart << {
            :item => cart_item[:item] + " W/COUPON",
            :price => discount_price,
            :clearance => cart_item[:clearance],
            :count => cart_item[:count] - remaining
          }
          cart_item[:count] = remaining
          
        end        
        
      end
    }
    
  }
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
