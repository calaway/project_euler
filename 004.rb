multiplier = 999
multiplicand = 999
product = 1000000

def palindrome?(product)
  product.to_s == product.to_s.chars.reverse.join
end

# while true
#   (multiplier..999).to_a.reverse.each do |multiplicand|
#     product = multiplier * multiplicand
#     puts "#{multiplier} x #{multiplicand} = #{product}"
#     abort if palindrome?(product)
#   end
#   multiplier -= 1
# end

while true
  x, y = multiplier, multiplicand
  while x < 1000
    puts("WARNING: #{x*y} is not less than #{product}") if x * y >= product
    product = x * y
    puts "#{x} x #{y} = #{product}"
    abort if palindrome?(product)
    x += 1
    y -= 1
    sleep(0.05)
  end
  multiplier == multiplicand ? multiplicand -= 1 : multiplier -=1
end
