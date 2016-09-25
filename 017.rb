all_numbers = []

ones = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
# ones = ones.map { |e| e.length }

p all_numbers += ones

teens = %w(eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty)

p all_numbers += teens

tens = ["none", "teen", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
# tens = tens.map { |e| e.length }.unshift(0)

(21..99).each do |number|
  if number % 10 == 0
    all_numbers << tens[number.to_s[0].to_i]
  else
    all_numbers << tens[number.to_s[0].to_i] + " " + ones[number.to_s[1].to_i]
  end
end

(100..999).each do |number|
  if number % 100 == 0
    all_numbers << ones[number.to_s[0].to_i] + " hundred"
  else
    all_numbers << ones[number.to_s[0].to_i] + " hundred and " + all_numbers[number.to_s[1..2].to_i]
  end
end

p all_numbers << "one thousand"

total_letters = all_numbers.reduce(0) do |sum, number|
  sum += number.gsub(" ", "").length
end

puts total_letters
