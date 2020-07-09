require_relative './part_1_solution.rb'
require "pry"

def apply_coupons(cart, coupons)
  # 1. See if the coupons apply to any items
  # 2. Identify any items that do have valid coupons
  # 3. See if we have enough items to have the coupon apply
  # 4. If we do, the create new item in basket, with "W/Coupon label"
  #   - Price is Total price / Amount; count = Amount
  # 5. Modify original item
  #   - count = remainder of original amount % amount in discount
  coupons.each do |coupon|
    cart.each do |item|
      target_item = find_item_by_name_in_collection(item[:item], cart)
      if coupon[:item] == target_item[:item] && target_item[:count] >= coupon[:num]
        discounted_target_item = target_item.clone
        discounted_target_item[:item] = "#{item[:item]} W/COUPON"
        discounted_target_item[:price] = coupon[:cost]/coupon[:num]
        discounted_target_item[:count] = coupon[:num]
        cart << discounted_target_item
        target_item[:count] = target_item[:count]%coupon[:num]
        item = target_item
      end
    end
  end
  puts cart
  return cart
end


def apply_clearance(cart)
  discount = 0.8
  cart.each do |item|
    target_item = find_item_by_name_in_collection(item[:item], cart)
    if target_item[:clearance]
      target_item[:price] = discount*target_item[:price]
      target_item[:price].round(2)
    end
  end
  return cart
end
      

def checkout(cart, coupons)
  cart_discount = 0.9
  consol_cart = consolidate_cart(cart)
  consol_coup_cart = apply_coupons(consol_cart,coupons)
  sub_total_cart = apply_clearance(consol_coup_cart)
  sum = 0.0
  #binding.pry
  #puts sub_total_cart
  #puts coupons
  sub_total_cart.each do |item|
    sum += item[:price]*item[:count]
  end
  if sum > 100.0
    sum = sum * cart_discount
  end
  return sum.round(2)
end
    
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
