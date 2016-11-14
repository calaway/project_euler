# Calculate the first x fibonacci numbers

@sequence = []

def fibonacci(n)
  @sequence[n] ||= begin
    if n <= 1
      n
    else
      fibonacci(n - 1) + fibonacci(n - 2)
    end
  end
end

(0..100).each do |index|
  @sequence[index] = fibonacci(index)
end

p @sequence

# without recursion:

def fib2(n)
