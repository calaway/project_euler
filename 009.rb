a = 1
b = 2
c = 1000 - a - b
counter = 0

while a < 1000
  while b < c
    counter += 1
    delta = a**2 + b**2 - c**2
    puts "#{counter} [#{a}, #{b}, #{c}] #{delta}"
    if delta == 0
      abort
    end
    b += 1
    c = 1000 - a - b
  end
  a +=1
  b = a + 1
  c = 1000 - a - b
end
