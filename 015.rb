@cache = {}

def lattice(rows, cols)
  @cache[[rows, cols]] ||= begin
    if rows == 0 || cols == 0
      1
    else
      lattice(rows - 1, cols) +
      lattice(rows, cols - 1)
    end
  end
end

x = 20
puts lattice(x, x)
