def collatz(n)
  counter = 1
  # print "#{n}, "
  while n != 1
    if n.even?
      n = n / 2
    else
      n = 3 * n + 1
    end
    counter += 1
    # print "#{n}, "
  end
  # puts ": #{counter}"
  counter
end

index = 1
maximum = [0, 0]

until index == 1000000
  collatz_number = collatz(index)
  if collatz_number > maximum[1]
    maximum = [index, collatz_number]
    puts "#{index} => #{collatz_number}"
  end
  index += 1
end
