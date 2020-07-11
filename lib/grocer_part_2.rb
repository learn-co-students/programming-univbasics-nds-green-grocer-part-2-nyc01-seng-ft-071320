require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  coupon_cart = []
  coupons.each do |element|
    coup_element = {}
    for_clearance = find_item_by_name_in_collection(element[:item], items)
    coup_element[:item] = "#{element[:item]} W/COUPON"
    coup_element[:price] = element[:cost]/element[:num]
    coup_element[:clearance] = for_clearance[:clearance]
    coup_element[:count] = element[:num]
    coupon_cart << coup_element
  end
  cart.each do |cart_elem|
    coupon_cart.each do |coup_elem|
      if "#{cart_elem[:item]} W/COUPON" == coup_elem[:item] && cart_elem[:count] >= coup_elem[:count]
        cart_elem[:count] = cart_elem[:count] - coup_elem[:count]
        cart << coup_elem
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |element|
    if element[:clearance] == true
      element[:price] = element[:price]*0.8
      element[:price].round(2)
    end
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total_price = 0
  cart.each do |element|
    price = element[:price]*element[:count]
    total_price = total_price + price
  end
  if total_price > 100
    total_price = total_price * 0.9
  end
  total_price.round(2)
end
