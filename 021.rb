def divisors(n)
  (1..n/2).find_all do |trial_divisor|
    n % trial_divisor == 0
  end
end

def d(n)
  (1..n/2).reduce(0) do |sum, trial_divisor|
    sum += trial_divisor if n % trial_divisor == 0
    sum
  end
end

def amicable_numbers_under(n)
  (1...n).find_all do |a|
    b = d(a)
    d(b) == a && b != a
  end
end
