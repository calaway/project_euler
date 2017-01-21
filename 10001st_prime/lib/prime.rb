class Prime
  def is_prime?(number)
    sqrt = Math.sqrt(number).floor
    (2..sqrt).all? do |divisor|
      number % divisor != 0
    end
  end

  def index(nth)
    dividend = 1
    index = 0

    until index == nth do
      dividend += 1
      if is_prime?(dividend)
        print "#{dividend}, "
        index += 1
      end
    end

    dividend
  end
end
