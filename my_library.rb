module MyLibrary
  def self.divisors(n)
    (1..n/2).find_all do |trial_divisor|
      n % trial_divisor == 0
    end
  end
end
