class GiftExchange
  attr_reader :players

  def initialize(filename)
    lines = get_players(filename)
    @players = parse_players(lines)
  end

  def get_players(filename)
    File.readlines(filename)
  end

  def parse_players(lines)
    players = lines.map do |line|
      player = line.chomp.split
      [player.first, player.last.to_i]
    end
    players.to_h
  end

  def assign
    from = players.keys
    to = players.keys.shuffle
    from.zip(to).to_h
  end

  def valid?(assignment)
    assignment.all? do |from, to|
      puts "is invalid: #{from} => #{to}" if players[from] == players[to]
      players[from] != players[to]
    end
  end

  def self.run(filename)
    gift = GiftExchange.new(filename)
    valid = false
    until valid
      assignment = gift.assign
      puts assignment
      valid = gift.valid?(assignment)
      sleep 5
    end
    assignment
  end
end

puts GiftExchange.run(ARGV[0])
