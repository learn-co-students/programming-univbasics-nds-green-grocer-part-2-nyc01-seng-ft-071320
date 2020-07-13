require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
result = []

cart.each { |cart_item|
    
    coupons.each { |coupon_item|
    
      if coupon_item[:item] == cart_item[:item]
        result << {
          :item => cart_item[:item],
          :price => cart_item[:price],
          :clearance => cart_item[:clearance],
          :count => cart_item[:count] - coupon_item[:num]
        }
        
        cart_item[:item] = cart_item[:item] + " W/COUPON"
        cart_item[:price] = coupon_item[:cost] / coupon_item[:num]
        cart_item[:count] =  coupon_item[:num]
      end
    
    }
  }
  cart + result
end


def apply_clearance(cart)
  cart.each { |cart_item|
    if cart_item[:clearance]
      cart_item[:price] = cart_item[:price] * 0.8.round(2)
    end
  }
end

def checkout(cart, coupons)
  total = 0
  apply_clearance(apply_coupons(consolidate_cart(cart), coupons)).each { |item|
    total += item[:price] * item[:count]
  }
  
  total *= 0.9 if total > 100
  
  total.round(2)
end
