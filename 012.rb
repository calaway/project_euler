

def divisors(n)
  (1..(Math.sqrt(n).floor)).each_with_object([]) do |potential_divisor, all_divisors|
    if n % potential_divisor == 0
      all_divisors << potential_divisor << n / potential_divisor
    end
  end
end

index = 1
triangular = 0
maximum = 0

while maximum < 500
  cardinality = divisors(triangular).count
  if cardinality > maximum
    maximum = cardinality
    puts "index: #{index}, triangular: #{triangular}, number of divisors: #{cardinality}"
  end

  triangular += index
  index      += 1
end
