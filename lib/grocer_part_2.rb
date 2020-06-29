require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

   cart.each do |cart_item|
     coupon = {}
     coupons.each do |discount_item|
       if(cart_item[:item] == discount_item[:item] && cart_item[:count] >= discount_item[:num])
         coupon[:item] = "#{cart_item[:item]} W/COUPON"
         coupon[:price] = discount_item[:cost] / discount_item[:num]
         coupon[:clearance] = cart_item[:clearance]
         coupon[:count] = discount_item[:num]
         cart_item[:count] = cart_item[:count] - discount_item[:num]
         cart.push coupon
       end
     end
   end
   cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item|
    if(item[:clearance])
      item[:price] = item[:price] - (item[:price] * 0.2)
    end
  end
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
  collection_in_cart = consolidate_cart(cart)
  cart_with_coupons_applied = apply_coupons(collection_in_cart, coupons)
  total_discounts = apply_clearance(cart_with_coupons_applied)
  total = 0 
  total_discounts.each do |item|
    total_of_same_item = item[:price] * item[:count]
    total+= total_of_same_item
  end
  if(total > 100)
    total = total - (total * 0.10)
  end
  total
end
