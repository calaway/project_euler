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
      puts "is invalid: #{from} => #{to}" if players[from] == players[to] && ENV["test"] != "true"
      players[from] != players[to]
    end
  end

  def self.run(filename)
    gift = GiftExchange.new(filename)
    valid = false
    until valid
      assignment = gift.assign
      sleep 1 unless ENV["test"] == "true"
      puts assignment unless ENV["test"] == "true"
      valid = gift.valid?(assignment)
    end
    puts "is valid =)" unless ENV["test"] == "true"
    assignment
  end
end

unless ENV["test"] == "true"
  filename = ARGV[0] || "names.txt"
  GiftExchange.run(filename)
end
