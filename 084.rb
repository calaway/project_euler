def monopoly(number_of_turns, dice_sides)
  landed = Array.new(40, 0)
  current = 0
  number_of_turns.times do
    die1 = rand(dice_sides) + 1
    die2 = rand(dice_sides) + 1
    current = (current + die1 + die2) % 40
    # print " + #{die1 + die2} = #{current}"
    current = special(current)
    # print " => #{current}"
    landed[current] += 1
    # puts
  end
  landed
end

@cc1 = [0, 10, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2].shuffle
# puts "cc1 = #{@cc1}"
@cc2 = [0, 10, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17].shuffle
# puts "cc2 = #{@cc2}"
@cc3 = [0, 10, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33].shuffle
# puts "cc3 = #{@cc3}"
@ch1 = [0, 10, 11, 24, 39, 5, 15, 15, 12, 4, 7, 7, 7, 7, 7, 7].shuffle
# puts "ch1 = #{@ch1}"
@ch2 = [0, 10, 11, 24, 39, 5, 25, 25, 28, 19, 22, 22, 22, 22, 22, 22].shuffle
# puts "ch2 = #{@ch2}"
@ch3 = [0, 10, 11, 24, 39, 5, 5, 5, 12, 33, 36, 36, 36, 36, 36, 36].shuffle
# puts "ch3 = #{@ch3}"

def special(current)
  if current == 30
    10
  elsif current == 2
    @cc1.rotate!
    @cc1.first
  elsif current == 17
    @cc2.rotate!
    @cc2.first
  elsif current == 33
    @cc3.rotate!
    @cc3.first
  elsif current == 7
    @ch1.rotate!
    @ch1.first
  elsif current == 22
    @ch2.rotate!
    @ch2.first
  elsif current == 36
    @ch3.rotate!
    @ch3.first
  else
    current
  end
end

turns = ARGV[0].to_i
sides = ARGV[1].to_i
landed = monopoly(turns, sides)
# p landed
landed_with_index = landed.map.with_index { |count, index| [index, 100 * count/turns.to_f] }
landed_with_index
sorted = landed_with_index.sort_by { |square| square.last }.reverse
puts sorted.take(6)
