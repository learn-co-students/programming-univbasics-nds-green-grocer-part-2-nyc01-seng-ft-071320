require_relative './part_1_solution.rb'

coupons=[
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "BEER", :num => 2, :cost => 20.00},
  {:item => "CHEESE", :num => 3, :cost => 15.00}
]

cart =[
  {:item => "AVOCADO", :price => 3.00, :clearance => true},
  {:item => "AVOCADO", :price => 3.00, :clearance => true},
  {:item => "PEANUT BUTTER", :price => 3.00, :clearance => true},
  {:item => "KALE", :price => 3.00, :clearance => false},
  {:item => "SOY MILK", :price => 4.50, :clearance => true},
  {:item => "AVOCADO", :price => 3.00, :clearance => true},
  {:item => "KALE",    :price => 3.00, :clearance => false}
]

cart2 =[
  {:item => "BEER", :price => 13.00, :clearance => false},
  {:item => "BEER", :price => 13.00, :clearance => false},
  {:item => "BEER", :price => 13.00, :clearance => false},
  {:item => "BEETS", :price => 2.50, :clearance => false},

]

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart=[]
  # coupon=[]
  cart.each do|k|
    x=nil
    coupons.each do|coup|
      if k[:item] == coup[:item] && k[:count]>=coup[:num]
        k[:count]=k[:count]-coup[:num]
        x={
          :item=>k[:item]+" W/COUPON",
          :price=>coup[:cost]/coup[:num],
          :clearance=>k[:clearance],
          :count=>coup[:num]
        }
      end
    end
    new_cart<<k
    new_cart<<x if x!=nil
  end
  new_cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do|k|
    k[:price]=(k[:price]*0.8).round(2) if k[:clearance]==true
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
  c_cart=consolidate_cart(cart)
  coupon_cart=apply_coupons(c_cart,coupons)
  final_cart=apply_clearance(coupon_cart)
  net=0.00
  final_cart.each do|item|
    net+=item[:price]*item[:count].to_f
  end
  net=net*0.9 if net>100.00
  net
end

cart1=consolidate_cart(cart2)
p cart1
p apply_coupons(cart1, coupons)
# p checkout(cart,coupons)
