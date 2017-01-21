class Prime
  def is_prime?(number)
    if number == 2
      true
    elsif number % 2 == 0
      false
    else
      sqrt = Math.sqrt(number).floor
      (3..sqrt).step(2).all? do |divisor|
        number % divisor != 0
      end
    end
  end

  def index(nth)
    dividend = 1
    index = 0

    until index == nth do
      dividend += 1
      if is_prime?(dividend)
        index += 1
      end
    end

    dividend
  end
end
