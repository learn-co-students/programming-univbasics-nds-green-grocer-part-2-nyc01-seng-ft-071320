require_relative './part_1_solution.rb'
def apply_coupons(cart, coupons)

i = 0
while i < coupons.length do

j = 0
while j < cart.length do 

if coupons[i][:item] == cart[j][:item]

  if coupons[i][:num] <= cart[j][:count]

cart[j][:count] -= coupons[i][:num]

cart << {
  :item => "#{cart[j][:item]} W/COUPON",
  :price => coupons[i][:cost].to_f / coupons[i][:num].to_f,
  :clearance => cart[j][:clearance],
  :count => coupons[i][:num]
  }
  end
end
          j += 1
        end  
      i += 1
    end
  cart
end
#---------------------------------------------------------------#

def apply_clearance(cart)
i = 0
while i < cart.length

if cart[i][:clearance] == true
cart[i][:price] = cart[i][:price] - cart[i][:price] * 0.2 
cart[i][:price].round(2)
end
      i += 1
    end
  cart
end

#--------------------------------------------------------------------#

def checkout(cart, coupons)
total = 0.0
new_cart = apply_clearance(apply_coupons(consolidate_cart(cart),coupons))

i=0

while i < new_cart.length
total += new_cart[i][:price] * new_cart[i][:count]
i+=1 
end

pp new_cart

if total >= 100
total = total - total * 0.1
end

total
end
