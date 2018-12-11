require "pry"

def consolidate_cart(cart)
  # code here
conCart = {}
  cart.map do |e|
    e.map do |k,v|
      v[:count] = cart.count(e)
    end
  end

  cart.uniq!

  cart.each do |e|
    e.each do |k,v|
      conCart.merge!(k => v)
    end
  end

conCart

end

def apply_coupons(cart, coupons)

  coupons.each do |h|
    count = coupons.count(h)
    if cart.keys.include?(h[:item]) && cart[h[:item]][:count] >= h[:num] * count
      cart.merge!({"#{h[:item]} W/COUPON" => {price: h[:cost].to_f, clearance: cart[h[:item]][:clearance], count: count } })
      cart[h[:item]][:count] = cart[h[:item]][:count] - h[:num] * count
    elsif cart.keys.include?(h[:item]) && cart[h[:item]][:count] >= h[:num]
      cart.merge!({"#{h[:item]} W/COUPON" => {price: h[:cost].to_f, clearance: cart[h[:item]][:clearance], count: 1 } })
      cart[h[:item]][:count] = cart[h[:item]][:count] - h[:num]
    end
  end
cart
end


def apply_clearance(cart)

  cart.map do |k,v|
    if v[:clearance] == true
      v[:price] = v[:price] - (v[:price] * 20.0) / 100.0
    end
  end

cart
end



def checkout(cart, coupons)

  conCart = consolidate_cart(cart)

  couponCart = apply_coupons(conCart, coupons)

  finalCart = apply_clearance(couponCart)

  total = 0

  finalCart.each do |k,v|
    if v[:count] > 0
      total += (v[:price] * v[:count])
    end
  end

 if total > 100
   total = total - (total * 10) / 100
 else
   total
 end

end
