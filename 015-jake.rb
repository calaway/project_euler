@cached_latices = {[0, 0] => 1}

def lattice(rows, columns)
  if rows == 0 || columns == 0
    1
  else
    # Retrieve the "down_path" from cache or calculate it via recursion
    if @cached_latices[[rows - 1, columns]]
      down_path = @cached_latices[[rows - 1, columns]]
    else
      down_path = lattice(rows - 1, columns)
      @cached_latices[[rows - 1, columns]] = down_path
    end

    # Retrieve the "right_path" from cache or calculate it via recursion
    if @cached_latices[[rows, columns - 1]]
      right_path = @cached_latices[[rows, columns - 1]]
    else
      right_path = lattice(rows, columns - 1)
      @cached_latices[[rows, columns - 1]] = right_path
    end

    down_path + right_path
  end
end


#
# Here is a shorter solution. It uses a some smart-ass syntax tricks, but
# should otherwise be readable. Key difference between implementations:
#
# A function memoizes *itself*. It does not care about the outcome of other
# function calls. This is the truly essential point that I think your soluition
# does not account for, which makes things far more complex.
#
# That said, if I were to truly approach this problem, I wouldn't use
# memoization. Instead, I'd try to walk diagonals (and note that this is really
# a Pascal's Triangle problem). By "walk diagonals" I mean calculate the value
# of one diagonal from the previous set. i.e.:
#
# a b c d
# b c d e
# c d e f
# d e f g
#
# That would involve seven function calls, each one examining the value of all
# points sharing the same letter.
#
# Anyway, I hope you find this useful.
#

@cache = {}

def lattice2(rows, cols)
  @cache[[rows, cols]] ||= begin
    if rows == 0 || cols == 0
      1
    else
      lattice2(rows - 1, cols) + # up path
      lattice2(rows, cols - 1)   # left path
    end
  end
end


rows = 20
columns = 20
puts lattice(rows, columns)

puts lattice2(20, 20)
